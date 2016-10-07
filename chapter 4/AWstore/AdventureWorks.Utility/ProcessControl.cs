using System;
using System.Collections.Generic;
using System.Text;
using System.Web;

namespace AdventureWorks.Utility
{
    public class ProcessControl
    {
        private static string GetAppPath()
        {
            string AppPath = HttpContext.Current.Request.ApplicationPath;
            if (!AppPath.EndsWith("/"))
            {
                AppPath = AppPath + "/";
            }
            
            return AppPath;
        
        }
        public static string GetSearchPageURL()
        {
            return GetAppPath() + Constants.SEARCHPAGE_URL;
        }

        public static string GetHomePageURL()
        {
            return GetAppPath() + Constants.HOMEPAGE_URL;
        }

        public static string GetDestinationPageURL(string storename)
        {
            System.Text.StringBuilder sbURL = new System.Text.StringBuilder();

            sbURL.Append(GetAppPath());
            sbURL.Append(Constants.DESTINATIONPAGE_URL);
            sbURL.Append("?");
            sbURL.Append(Constants.STORENAME_PARAM);
            sbURL.Append("=");
            sbURL.Append(storename);

            return sbURL.ToString();

        }

        public static string GetStoreName()
        {
            string storename = string.Empty;

            if (HttpContext.Current.Request.QueryString[Constants.STORENAME_PARAM] != null)
            {

                storename = HttpContext.Current.Request.QueryString[Constants.STORENAME_PARAM];
            }

            return storename;
        }

    }
}
