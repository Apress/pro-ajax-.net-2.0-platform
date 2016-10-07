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
using AdventureWorks.Utility;

public partial class SearchPage_Objects : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // We need to register this page with Anthem, so that it is
        // Ajax Aware.
        Anthem.Manager.Register(this);

        if (!Page.IsPostBack)
        {
            lnkHome.NavigateUrl = ProcessControl.GetHomePageURL();         
        }
    
    
    }


    [Anthem.Method]
    public StoreCollection RetrieveRows(string searchterm)
    {
        // call the business layer
        return Store.GetStoreNames(searchterm);
    }


    protected void btnGo_Click(object sender, EventArgs e)
    {
        Server.Transfer(ProcessControl.GetDestinationPageURL(keyword.Value));

    }
}
