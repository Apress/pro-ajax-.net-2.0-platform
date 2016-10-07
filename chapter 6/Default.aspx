<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<script type="text/javascript" language="javascript">
 xmlhttp = false;
 var requestURL = "dataFetch.aspx?term=";
 
function getNames(currentTerm)
{

    if (currentTerm.length > 0)
    {
        // a proper term has been entered
        var url = requestURL + currentTerm;
 
        getHTTPRequestObject();

        if(xmlhttp)
        {
            xmlhttp.open("GET", url, true);
            xmlhttp.onreadystatechange = callback; 
            xmlhttp.send(null);
        }
    }
    else
    {
        //no search term entered - empty the div
        var findDIV = document.getElementById("divResults")
        findDIV.className = 'hide';
    }  
}

function callback(response)
{
        if(xmlhttp.readyState == 4) 
        {
            if(xmlhttp.status ==200)
            {
                eval("var objResults = " + xmlhttp.responseText);
                
              var displaytext = "";
              
              for (var i=0; i < objResults.Results.shops.length; i++)
              {
                displaytext += objResults.Results.shops[i].Name + "<br>"; 
              }
              if(displaytext.length > 0)
              {
                    var findDIV = document.getElementById("divResults");
                    findDIV.className = 'show';
                    findDIV.innerHTML = displaytext;
              }
                   
            }
        }
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


<head runat="server">
    <title>Summary Application</title>
    <style type="text/css">
    .hide
    {
        display:none;
    }
    .show
    {
        display:block;
        width:230px;
    }
    #divResults
    {
        /* this is
         a comment block! */
        
        background-color:gainsboro;
    
        /* this is a single comment line */
    }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <strong>Adventure Works Store Finder</strong><br />
        <input type="text" id="txtName" autocomplete="off" onkeyup="getNames(this.value);" />    
    </div>
    <div id="divResults"></div>
    </form>
</body>
</html>
