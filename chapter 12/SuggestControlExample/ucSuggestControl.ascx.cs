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

public partial class ucSuggestControl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Anthem.Manager.Register(this);
    }

    [Anthem.Method]
    public DataTable RetrieveRows(string searchterm)
    {

        SqlConnection conn = new SqlConnection("Data Source=(local);Initial Catalog=AdventureWorks;Integrated Security=SSPI");
        DataTable dtReturn = new DataTable();

        conn.Open();
        SqlCommand cmd = new SqlCommand("Select Top 10 Name from Sales.Store where Name like @searchterm Order By Name", conn);
        SqlParameter param = new SqlParameter();
        param.ParameterName = "@searchterm";
        searchterm.Trim().Replace("'", "''");
        searchterm += "%";
        param.Value = searchterm;
        cmd.Parameters.Add(param);

        SqlDataAdapter adpt = new SqlDataAdapter(cmd);
        adpt.Fill(dtReturn);
        conn.Close();


        // send the DataTable back to the CallBack function
        return dtReturn;
    }
    protected override void OnInit(EventArgs e)
    {
        
        base.OnInit(e);

        string jcode = "<script language=\"javascript\" type=\"text/javascript\">ClientID = '" + this.ClientID + "_" + "';BodyLoad();</script>";
        Page.ClientScript.RegisterStartupScript(typeof(Page),"suggest_control", jcode);
    }
}
