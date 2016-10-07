<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Ajax Security</title>
</head>
<body>
    <script type="text/javascript" language="javascript">
    function CallAjax()
    {
         Anthem_InvokePageMethod('SayHello', [], AjaxCallBack);
    }
    function AjaxCallBack(result)
    {
        alert(result.value);
    }
    </script>
    <form id="form1" runat="server">
     <strong>
     Logged In Status: </strong>
            <asp:LoginView ID="LoginView1" runat="server">
            <LoggedInTemplate>
                Logged In.
            </LoggedInTemplate>
            <AnonymousTemplate>
                Not Logged In.<br />
            </AnonymousTemplate>
        </asp:LoginView>
         &nbsp;
         <br />
    <table width="100%">
     <tr>
       <td valign="top"><strong>New To The Site?&nbsp; Sign Up Here!</strong>
        <asp:CreateUserWizard ID="CreateUserWizard1" runat="server">
            <WizardSteps>
                <asp:CreateUserWizardStep runat="server">
                </asp:CreateUserWizardStep>
                <asp:CompleteWizardStep runat="server">
                </asp:CompleteWizardStep>
            </WizardSteps>
        </asp:CreateUserWizard>
        </td>
       <td align="right" valign="top">
            <asp:Login ID="Login1" runat="server"></asp:Login>
       </td>
     </tr>
    </table>
        <div>
            <br />
            Call Ajax: <input id="Button1" type="button" value="Go!" onclick="CallAjax();" /><br />
            <br />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="Default2.aspx">Go to Members Only Page!</asp:HyperLink><br />
            <br />
        </div>
    </form>
</body>
</html>
