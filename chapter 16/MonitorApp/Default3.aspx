<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="Default3" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>JSON Reader</title>
</head>
<script type="text/javascript" language="javascript">
var xmlhttp = false;

getHTTPRequestObject();

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

function callback()
{
        if(xmlhttp.readyState == 4) 
        {
            if(xmlhttp.status == 200)
            { 
              var response = xmlhttp.responseText;
              var finddiv = document.getElementById("divResponse");
              finddiv.innerHTML = response;
            } 
        }
}

function btnClick()
{
    // retrieve the JSON text from the local file.
    xmlhttp.open("GET", "JSON.txt", true);
    xmlhttp.onreadystatechange = callback;
    xmlhttp.send(null);
}
</script>

<body>
    <form id="form1" runat="server">
        <input id="btnGetJSON" type="button" value="Get JSON" onclick="btnClick();" />
        <div id="divResponse"></div>
    </form>
</body>
</html>
