<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Ajax Applicaton</title>
</head>
<body>
    <form id="form1" runat="server">
    <script type="text/javascript">
        function SayHello()
        {
            Anthem_InvokePageMethod('GetMessage', [document.getElementById("TextBox1").value], HelloCallBack);
        }
        function HelloCallBack(result)
        {
            document.getElementById("divResults").innerHTML = result.value;
        }
    </script>
    <div>
        Enter Your First Name:
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <input id="Button1" type="button" value="Go!" onclick="SayHello();" />
    </div>
    <div id="divResults"></div>
    </form>
</body>
</html>
