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

public partial class SearchPage_Objects : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // We need to register this page with Ajax class, so that it is
        // Ajax.Net Aware.
        Anthem.Manager.Register(this);

    }


    [Anthem.Method]
    public StoreCollection RetrieveRows(string searchterm)
    {

        SqlConnection conn = new SqlConnection(
            "Data Source=(local);Initial Catalog=AdventureWorks;Integrated Security=SSPI");
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

        StoreCollection strCollection = new StoreCollection();

        for (int i = 0; i < dtReturn.Rows.Count; i++)
        {
            Store stre = new Store();
            stre.Name = (string)dtReturn.Rows[i]["Name"];
            strCollection.Add(stre);
        }

        // send the CustomerCollection back to the CallBack function
        return strCollection;
    }


}
