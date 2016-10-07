using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace AdventureWorks.Core.Data
{
    class StoreData
    {
        public static StoreCollection GetStoreNames(string searchterm)
        {
            SqlConnection conn = new SqlConnection(
             "Data Source=(local);Initial Catalog=AdventureWorks;Integrated Security=SSPI");
            DataTable dtReturn = new DataTable();

            conn.Open();
            // Go get the top 10 store names from AdventureWorks that are like users search criteria
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
}
