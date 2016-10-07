<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<script type="text/javascript" language="javascript">
var xmlhttp = false;

getHTTPRequestObject();

if(xmlhttp)
{
    xmlhttp.open("GET", "http://api.local.yahoo.com/MapsService/V1/mapImage?appid=YahooMap&zip=49503", true);
    xmlhttp.onreadystatechange = function() 
       {
        if(xmlhttp.readyState == 4) 
        {
            alert(xmlhttp.responseText);
        }
       }
      xmlhttp.send(null);
}

function getHTTPRequestObject()
{
    try
    {
        // try legacy object first
        xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch(e)
    {
        try
        {
            // try IE implementation now
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        catch(E)
        {
            xmlhttp = false;
        }
    }
    if(!xmlhttp && typeof XMLHttpRequest!= 'undefined')
    {
        // we must be using a mozilla based browser
        // so create a native request object now
        xmlhttp = new XMLHttpRequest();
    }
}
</script>


<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        XMLHttpRequest hard at work!
    </div>
    </form>
</body>
</html>