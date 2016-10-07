using System;
using System.Web;
using System.Data;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Text;


/// <summary>
/// Summary description for wsGetStoreNames
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class wsGetStoreNames : System.Web.Services.WebService {

    public wsGetStoreNames ()
    {
        // add stuff here for constructor
    }

    [WebMethod]
    public string[] GetNames(string prefixText, int count)
    {
            SqlConnection conn = new SqlConnection("Data Source=(local);Initial Catalog=AdventureWorks;Integrated Security=SSPI");
            DataTable dtReturn = new DataTable();

			StringBuilder sb = new StringBuilder();
			sb.Append("SELECT TOP ");
			sb.Append(count.ToString());
			sb.Append(" Name FROM Sales.Store WHERE Name LIKE");
			sb.Append(" @searchterm ORDER BY Name");

			SqlCommand cmd = new SqlCommand(sb.ToString(), conn);
			SqlParameter param = new SqlParameter();
			param.ParameterName = "@searchterm";
			prefixText.Trim().Replace("'", "''");
			prefixText += "%";
			param.Value = prefixText;
			cmd.Parameters.Add(param);

		    SqlDataAdapter adpt = new SqlDataAdapter(cmd);
            adpt.Fill(dtReturn);
            
            conn.Close();


            string[] strReturn = new string[dtReturn.Rows.Count];
            for(int i = 0; i < dtReturn.Rows.Count; i++)
            {
                strReturn[i] = (string)dtReturn.Rows[i]["Name"];
            }

            return strReturn;
    }
}

