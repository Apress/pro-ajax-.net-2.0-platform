using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Anthem.Manager.Register(this);
    }

    [Anthem.Method]
    public DataTable PopulateMap(string zipCode, int miles, int severity)
    {

        string urlpart1 = "http://maps.yahoo.com/traffic.rss?csz=";
        string urlpart2 = "&mag=";
        string urlpart3 = "&minsev=";
        DataTable returnDataTable = new DataTable();

        // make the call and do map
        DataSet ds = new DataSet();
        string urlComplete = urlpart1 + zipCode + urlpart2 + miles.ToString()
         + urlpart3 + severity.ToString();

        ds.ReadXml(urlComplete);
        DataTable rsstbl = ds.Tables[2];

        returnDataTable.Columns.Add("latitude");
        returnDataTable.Columns.Add("longitude");
        returnDataTable.Columns.Add("title");
        returnDataTable.Columns.Add("description");
        returnDataTable.Columns.Add("severity");
        returnDataTable.Columns.Add("category");

        DataRow buildrow = null;
        foreach (DataRow row in rsstbl.Rows)
        {
            buildrow = returnDataTable.NewRow();
            buildrow["title"] = row["title"];
            buildrow["description"] = row["description"];
            buildrow["severity"] = row["severity"];
            buildrow["category"] = row["category"];

            string[] foundrow = row["link"].ToString().Split('&');
            foreach (string strPoints in foundrow)
            {
                if (strPoints.IndexOf("mlt=") > -1)
                {
                    string[] strLat = strPoints.Split('=');
                    buildrow["latitude"] = strLat[1];
                }

                if (strPoints.IndexOf("mln=") > -1)
                {
                    string[] strLon = strPoints.Split('=');
                    buildrow["longitude"] = strLon[1];
                }


            }
            returnDataTable.Rows.Add(buildrow);
        }
        return returnDataTable;
    }

}
