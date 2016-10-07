<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="TestingForm.aspx.cs" Inherits="_Default" %>

<%@ Register Src="ucSuggestControl.ascx" TagName="ucSuggestControl" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    		<table border="1">
        		<tbody>
		       	<tr>
			        <td valign="top">
			            <strong>Welcome to the Search Page!</strong>
			        </td>
			        <td valign="top">
                        <uc1:ucSuggestControl id="UcSuggestControl1" runat="server">
                        </uc1:ucSuggestControl></td>
					
                </tr>
		        </tbody>
		</table>
    </form>
</body>
</html>
