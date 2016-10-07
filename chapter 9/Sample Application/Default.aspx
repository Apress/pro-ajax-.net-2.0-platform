<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Web Service Test</title>
</head>
<body>
    <script type="text/javascript" language="javascript">
    function GetProductsList()
    {
        var maxamount = document.getElementById("txtPrice").value;
        
        Anthem_InvokePageMethod('GetProducts', [maxamount], ProductsCallback);
        
    }
    function ProductsCallback(response)
    {
        var findDiv = document.getElementById("divResults");
        findDiv.innerHTML = response.value;
    }
    </script>
    <form id="frmWebServiceTest" runat="server">
    <div>
        Enter Max Price:&nbsp;
        <asp:TextBox ID="txtPrice" runat="server" autocomplete="off"></asp:TextBox>&nbsp;
        <button id="btnGo" onclick="GetProductsList();">
            Go!</button>
        <br />
        <div id="divResults"></div>
    </div>
    </form>
</body>
</html>
