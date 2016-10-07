using System;
using AdventureWorks.Core.Data;    
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
	
        // Object methods

        public static StoreCollection GetStoreNames(string searchterm)
        {
            // call the data layer
            return StoreData.GetStoreNames(searchterm);
        }
	}

