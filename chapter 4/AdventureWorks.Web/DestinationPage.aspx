<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DestinationPage.aspx.cs" Inherits="DestinationPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Destination Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="color: black; background-color: gray">
        <strong style="font-size: xx-large">Welcome to the Destination Page!</strong><br />
        <asp:HyperLink ID="lnkHome" runat="server" ForeColor="White">>Home</asp:HyperLink><br />
        <asp:HyperLink ID="lnkSearch" runat="server" ForeColor="White">>Search</asp:HyperLink><br />
        <br />
        <br />
        <div id="divStoreInfo" runat="server" style="font-size:xx-large; color:White"></div>
    </div>
    </form>
</body>
</html>
