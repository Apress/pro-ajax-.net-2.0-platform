<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Chapter 8 Sample Application</title>
</head>
<body>
<script type="text/javascript" language="javascript">
function CallAjaxFunction()
{
    var findName = document.getElementById("txtName");
    Anthem_InvokePageMethod('SayHello',[findName.value] , AjaxFunctionCallback);
    
}

function AjaxFunctionCallback(response)
{
    alert(response.value);
}
</script>
    <form id="frmMain" runat="server">
    <div>
        Enter your name:
        <asp:TextBox ID="txtName" runat="server" ></asp:TextBox>
        <input id="btnGo" type="button" onclick="CallAjaxFunction();" value="Say Hello" /></div>
    </form>
</body>
</html>
