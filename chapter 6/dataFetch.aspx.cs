using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Text;
public partial class dataFetch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string searchterm = Request.QueryString["term"];

        SqlConnection conn = new SqlConnection("Data Source=(local);Initial Catalog=AdventureWorks;Integrated Security=SSPI");
        DataTable dtReturn = new DataTable();

        conn.Open();
        // Go get the top 10 store names from AdventureWorks that are like users search criteria
        SqlCommand cmd = new SqlCommand("Select Top 10 Name from sales.store where Name like @searchterm Order By Name", conn);
        SqlParameter param = new SqlParameter();
        param.ParameterName = "@searchterm";
        searchterm.Trim().Replace("'", "''");
        searchterm += "%";
        param.Value = searchterm;
        cmd.Parameters.Add(param);

        SqlDataAdapter adpt = new SqlDataAdapter(cmd);
        adpt.Fill(dtReturn);

        conn.Close();

        //build our JSON string now.
        StringBuilder sb = new StringBuilder();
        sb.Append("{\"Results\": { \"shops\": [");

        for (int i = 0; i < dtReturn.Rows.Count; i++)
        {
            sb.Append("{\"Name\":\"" + (string)dtReturn.Rows[i]["Name"] + "\"}");
            if (i <= (dtReturn.Rows.Count - 2))
            {
                sb.Append(",");
            }
        }

        sb.Append("]}}");

        Response.Write(sb.ToString());

    }
}
