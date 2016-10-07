using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
    
    [Serializable]
	public class Store
	{
		public Store()
		{
			//
			// TODO: Add constructor logic here
			//
		}

		// We only need one property for the purposes of this demo.

		private string _storename = string.Empty;
		/// <summary>
		/// Stores Name
		/// </summary>
		public string Name
		{
			get{return _storename;}
			set{_storename = value;}
		}
	
	}

