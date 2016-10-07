<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucNameTest.ascx.cs" Inherits="ucNameTest" %>
<script type="text/javascript">
	function ButtonClicked(ClientID)
	{
		var txtbox= document.getElementById(ClientID + "_txtName");
		alert("You entered: "  + txtbox.value);
	}
</script>

<div id="divBuyButton">
<asp:TextBox ID="txtName" runat="server"></asp:TextBox>
<br />
<input id="btnDisplay" type="button" value="Display Name" runat="server" />
</div>