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
using System.Xml;
using System.Text;

public partial class controls_ucCustomerLocator : System.Web.UI.UserControl, IWebPart
{

    protected string _title = "";
    public string Title
    {
        get { return _title; }
        set { _title = value; }
    }
    private string _subtitle = "";
    public string Subtitle
    {
        get { return _subtitle; }
        set { _subtitle = value; }
    }

    private string _titleurl = "";
    public string TitleUrl
    {
        get { return _titleurl; }
        set { _titleurl = value; }
    }

    private string _catalogIconImageUrl = "";
    public string CatalogIconImageUrl
    {
        get { return _catalogIconImageUrl; }
        set { _catalogIconImageUrl = value; }
    }

    protected string _description = "";
    public string Description
    {
        get { return _description; }
        set { _description = value; }
    }
    private string _titleIconImageUrl = "";
    public string TitleIconImageUrl
    {
        get { return _titleIconImageUrl; }
        set { _titleIconImageUrl = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
       
        Anthem.Manager.Register(this);
        string jcode = "<script language=\"javascript\" type=\"text/javascript\">ClientID = '" + this.ClientID + "_" + "';BodyStart();</script>";
        
        this.Page.ClientScript.RegisterStartupScript(typeof(Page), "customer_control", jcode);
    }

    [Anthem.Method]
    public string GetMapUrl(string zipcode)
    {

        string strMap = "http://api.local.yahoo.com/MapsService/V1/mapImage?appid=YahooMap&image_height=300&image_width=300&zoom=12&zip=" + zipcode;
        StringBuilder sb = new StringBuilder();
        XmlTextReader xr = null;

        xr = new XmlTextReader(strMap);
        sb.Append("<center><img src='");
        while (xr.Read())
        {
            if (xr.NodeType == XmlNodeType.Element && xr.Name == "Result")
            {

                sb.Append(xr.ReadString());
            }

        }
        sb.Append("' /></center>");
        return sb.ToString();
    }

    [Anthem.Method]
    public DataTable RetrieveRows(string searchterm)
    {
        //Data Source=(local);Initial Catalog=AdventureWorks;Integrated Security=True
        SqlConnection conn = new SqlConnection("Data Source=(local);Initial Catalog=AdventureWorks;Integrated Security=True");
        DataTable dtReturn = new DataTable();
        string sqlquery = "Select Top 10 Sales.Store.Name, Person.Address.PostalCode, Person.StateProvince.Name as State  from Sales.Store";
        sqlquery += " join Sales.CustomerAddress on Sales.Store.CustomerID = Sales.CustomerAddress.CustomerID";
        sqlquery += " join Person.Address on Person.Address.AddressID = Sales.CustomerAddress.AddressID";
        sqlquery += " join Person.StateProvince on Person.StateProvince.StateProvinceID = Person.Address.StateProvinceID";
        sqlquery += " where Person.Address.StateProvinceID in (Select StateProvinceID from Person.StateProvince";
        sqlquery += " where Person.StateProvince.CountryRegionCode = 'US') and Sales.Store.Name Like @searchterm Order By Name";
        
            conn.Open();
            // Go get the top 10 companynames from Northwind that are like users search criteria
            SqlCommand cmd = new SqlCommand(sqlquery, conn);
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


}
