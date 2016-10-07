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
        // we must first register our page with the library
        Anthem.Manager.Register(this);
    }

    // We must preface our Ajax aware methods with [Anthem.Method]
    [Anthem.Method]
    public string SayHello(string name)
    {
        // create and return a new string
        return "Hello " + name + "!";
    }
}
