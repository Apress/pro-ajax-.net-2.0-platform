using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class frmTaggingSample : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // We need to register this page with Ajax class, so that it is
		// Ajax.Net Aware.
        Anthem.Manager.Register(this);

        //  That is all that is needed for the ready reception of Ajax.Net
        //  Calls.
		//  Pretty cool?  Yes it is!
    }

    	[Anthem.Method]
	public string LoadImageTags(int ImageID)
	{
		//	This is our Ajax.Net ready function for loading the tags
        //  associated with the
		//	selected picture.
		//  We'll build an HTML table and return that as a string to the
        //  Ajax.Net Callback
		//  function.

		//  Lets go grab our data here
	string strHTMLOutput = null;
	SqlConnection conn = new SqlConnection("Data Source=(local);Initial Catalog=AjaxTaggingSample;Integrated Security=SSPI");

	SqlDataReader rdr = null;

	try
	{
	// This is typical ADO.NET processing here to Insert our new tag into the
    // database.
	// Need help with Database Development?  http://www.apress.com has a huge
    // selection of .Net books to get you started!
	conn.Open();
	SqlCommand cmd = new SqlCommand("Select * from ImageTags where ImageID = @imageid", conn);
	SqlParameter param  = new SqlParameter();
	param.ParameterName = "@imageid";
	param.Value         = ImageID;
	cmd.Parameters.Add(param);

	rdr = cmd.ExecuteReader();

	// We'll build our HTML table here
	System.IO.StringWriter swResponse = new System.IO.StringWriter();
	System.Web.UI.HtmlTextWriter htwResponse = new
    System.Web.UI.HtmlTextWriter(swResponse);

	HtmlTable tblResult = new HtmlTable();
	HtmlTableRow rowResult = new HtmlTableRow();
	HtmlTableCell cellResult = new HtmlTableCell();

	//  We'll add a Table Title Here
	rowResult = new HtmlTableRow();
	cellResult = new HtmlTableCell();
	cellResult.InnerText = "Tags:";
	rowResult.Cells.Add(cellResult);
	tblResult.Rows.Add(rowResult);
						
	//  For each row in the returned datareader, we'll build an HTML row
	//  and add it to the HTML table for rendering within the DIV tag.
	while (rdr.Read())
	{
		rowResult = new HtmlTableRow();
		cellResult = new HtmlTableCell();

		// The tag is added to the innerText of the cell
		StringBuilder strInnerHtml = new StringBuilder();
		strInnerHtml.Append("- " + rdr["TagName"].ToString());
		strInnerHtml.Append("<DIV id='btnDelete' style=\"CURSOR:hand; DISPLAY:inline;\"");
		strInnerHtml.Append("onclick=\"DeleteTag('" + ImageID.ToString() + "', '");
								
		strInnerHtml.Append(rdr["TagName"].ToString() + "');\" align='left'>[x]</DIV>");
 							
		cellResult.InnerHtml = strInnerHtml.ToString();

		rowResult.Cells.Add(cellResult);
		tblResult.Rows.Add(rowResult);
		}
					
		//  Dump the HTML table out to the StringWriter
		tblResult.RenderControl(htwResponse);
		strHTMLOutput = swResponse.ToString();
	}
	finally
	{
		// close the reader
		if (rdr != null)
			{
				rdr.Close();
			}
				if (conn != null)
					{
						conn.Close();
					}
	}

	//	Now we'll store the images ID in the hidden control for later usage:
	this.hidImageID.Value = ImageID.ToString();

	return strHTMLOutput;
}


[Anthem.Method]
public void AddTag(string TagName)
{
// We'll add our tag here
	
	// The application retrieves the ImageID from the value
	// of the hidden control.  We have access to the Page state!
	int intImageID = Convert.ToInt32(this.hidImageID.Value);

	//  Your DB connection string may be different based on the security settings
	//  that you have established.  On my machine I'm using integrated security
    //  for access.
	SqlConnection conn = new SqlConnection("Data Source=(local);Initial Catalog=AjaxTaggingSample;Integrated Security=SSPI");
			
	try
	{
	conn.Open();
	SqlCommand cmd = new SqlCommand("Insert Into ImageTags Values(@imageid, @tagname)", conn);
	cmd.Parameters.Add(new SqlParameter("@imageid", SqlDbType.Int));
	cmd.Parameters["@imageid"].Value = intImageID;
	cmd.Parameters.Add(new SqlParameter("@tagname", SqlDbType.VarChar, 50));
    cmd.Parameters["@tagname"].Value = TagName;

	cmd.ExecuteNonQuery();
				
	}
	catch (Exception e)
	{
		// We'll just do simple error handling here.
		Response.Write(e.Message);
	}
	finally
	{
		conn.Close();
	}

}

[Anthem.Method]
public void DeleteTag(string TagName)
{
	// We'll delete the selected tag from the database here
	// The application retrieves the ImageID from the value
	// of the hidden control.  We have access to the Page state!
    int intImageID = Convert.ToInt32(this.hidImageID.Value);

	//  Your DB connection string may be different based on the security settings
	//  that you have established.  On my machine I'm using integrated security
    //  For access.
	SqlConnection conn = new SqlConnection("Data Source=(local);Initial Catalog=AjaxTaggingSample;Integrated Security=SSPI");
			
	try
	{
		conn.Open();
		SqlCommand cmd = new SqlCommand("Delete From ImageTags Where ImageID = @imageid and TagName = @tagname", conn);
		cmd.Parameters.Add(new SqlParameter("@imageid", SqlDbType.Int));
		cmd.Parameters["@imageid"].Value = intImageID;
		cmd.Parameters.Add(new SqlParameter("@tagname",SqlDbType.VarChar, 50));
		cmd.Parameters["@tagname"].Value = TagName;

		cmd.ExecuteNonQuery();
				
	}
	catch (Exception e)
	{
		// We'll just do simple error handling here.
		Response.Write(e.Message);
	}
	finally
	{
		conn.Close();
	}
}

}
