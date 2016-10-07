<%@ Page Language="C#" AutoEventWireup="true" CodeFile="xhrAccess.aspx.cs" Inherits="xhrAccess" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>XmlHttpRequest and Web Services</title>
</head>
<script type="text/javascript" language="javascript">
var xmlhttp = false;
var objXmlDoc;

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
function GetProductsList()
{
    
    // instantiate xmlhttprequest object
    getHTTPRequestObject();
    
    
    // first get the textbox value.
    var maxamount = document.getElementById("txtPrice").value;
    
    var serviceUrl = "http://localhost/wsAdventureWorks/Service.asmx";
    var serviceNamespace = "http://adventureworksSystem.com/Products"
    
    // build the SOAP envelope now
    var strEnvelope = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"" +
     " xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" " +
     " xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
     "  <soap:Body>\n" + 
     "    <GetProducts xmlns=\"http://adventureworksSystem.com/Products\" >\n" +
     "       <MaxAmount>" + maxamount + "</MaxAmount>\n" + 
     "    </GetProducts>" + "  </soap:Body>" + "</soap:Envelope>";
    
    var serviceAction = serviceNamespace + "/GetProducts";

	xmlhttp.open("POST", serviceUrl, true);

    // assign the callback function
    xmlhttp.onreadystatechange = processResults;
	xmlhttp.setRequestHeader("Content-Type", "text/xml");
	xmlhttp.setRequestHeader("SOAPAction", serviceAction);
	xmlhttp.send(strEnvelope);
	    
}

function processResults()
{
    if (xmlhttp.readyState == 4) 
    {
      if (xmlhttp.status == 200) 
      {
            // create the XML object
            objXmlDoc = new ActiveXObject("Msxml2.DOMDocument");
            
            var serviceResponse = xmlhttp.responseText;
            
            objXmlDoc.loadXML(serviceResponse);

            if (objXmlDoc.parseError.errorCode != 0) 
	        {
		        var xmlErr = objXmlDoc.parseError;
	                alert("oops: " + xmlErr.reason);
	        }
	        else 
	        {
        	    ParseDataSet();	
	        }
      } 
       else 
      {
              alert(xmlhttp.statusText);
      }
    }
    
} 
function ParseDataSet()
{
    objNodeList = objXmlDoc.getElementsByTagName("Products");
    
    
    var stringout = "";
    if(objNodeList.length > 0)
    {
        stringout = "<table>" + 
        "<tr><td>Product ID</td><td>Name</td><td>List Price</td></tr>";
        
    }
    for (var i = 0; i < objNodeList.length; i++)
    {
      var dataNodeList;
      var ProductIDNode;
      var ProductNameNode;
      
      dataNodeList = objNodeList[i];
       
      ProductIDNode = getParsedElement(dataNodeList, "ProductID");
      ProductNameNode = getParsedElement(dataNodeList, "Name");
      PriceNode = getParsedElement(dataNodeList, "ListPrice");
      
      stringout = stringout + "<tr><td>" + ProductIDNode + "</td><td>" + ProductNameNode + "</td><td align='right'>" + formatCurrency(PriceNode) + "</td></tr>";
    
    }
    if(objNodeList.length > 0)
    {
        stringout = stringout + "</table>";
    }
    document.getElementById("divResults").innerHTML = stringout;
    
}
function getParsedElement(source, child)
{
    var childNode = source.getElementsByTagName(child);
    return childNode[0].firstChild.nodeValue;
}
function formatCurrency(amount)
{
	var i = parseFloat(amount);
	if(isNaN(i)) { i = 0.00; }
	var minus = '';
	if(i < 0) { minus = '-'; }
	i = Math.abs(i);
	i = parseInt((i + .005) * 100);
	i = i / 100;
	s = new String(i);
	if(s.indexOf('.') < 0) { s += '.00'; }
	if(s.indexOf('.') == (s.length - 2)) { s += '0'; }
	s = minus + s;
	return s;
}

</script>
<body>
    <form id="frmXHRWS" runat="server">
    <div>
        Enter Max Price:&nbsp;
        <asp:TextBox ID="txtPrice" runat="server"></asp:TextBox>
        <button id="btnGo" onclick="GetProductsList();" type="button">
            Go!</button>
        <br />
        <div id="divResults"></div>
    </div>
    </form>
</body>
</html>
