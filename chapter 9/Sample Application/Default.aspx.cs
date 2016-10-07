using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Dont forget to register your pages!
        Anthem.Manager.Register(this);
    }

    [Anthem.Method]
    public string GetProducts(string maxPrice)
    {

        decimal maxAmount = Decimal.Parse(maxPrice);
        
        DataSet newData = new DataSet();

        // create a new instance of the web service
        wsAdventureWorks.Service myWebService = new wsAdventureWorks.Service();

        // now assign the output of the web service to our dataset
        newData = myWebService.GetProducts(maxAmount);


        StringBuilder sb = new StringBuilder();
        
        // iterate thru the table rows, building an HTML table as we go
        if (newData.Tables["Products"].Rows.Count > 0)
        {
            sb.Append("<table>");
            sb.Append("<tr><td>Product ID</td><td>Product Name</td><td>List Price</td></tr>");

            foreach(DataRow dr in newData.Tables["Products"].Rows)
            {
                sb.Append("<tr>");
                sb.Append("<td>");
                sb.Append(dr["ProductID"]);
                sb.Append("</td>");
                sb.Append("<td>");
                sb.Append(dr["Name"]);
                sb.Append("</td>");
                sb.Append("<td align='right'>");
                sb.Append(String.Format("{0:c}", dr["ListPrice"]));
                sb.Append("</td>");
                sb.Append("</tr>");
            }
            sb.Append("</table>");
        }

        // we'll return the HTML table to the client side for assignment to the innerHTML property
        return sb.ToString();

    }
}
