<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Atlas Sample Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <atlas:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
        <br />
        <br />
        <div>
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource1"
                DataTextField="Name" DataValueField="StateProvinceID">
            </asp:DropDownList><br />
            <br />
            <atlas:UpdatePanel runat="server" ID="atlasPanel1">
            <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" DataKeyNames="CustomerID" DataSourceID="SqlDataSource2">
                <Columns>
                    <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" ReadOnly="True" SortExpression="CustomerID" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="PostalCode" HeaderText="PostalCode" SortExpression="PostalCode" />
                    <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
                </Columns>
            </asp:GridView>
            </ContentTemplate>
            <Triggers>
            <atlas:ControlEventTrigger ControlID="DropDownList1" EventName="SelectedIndexChanged" />
            </Triggers>
            </atlas:UpdatePanel>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AdventureWorksConnectionString %>"
                SelectCommand="Select Sales.Store.CustomerID, Sales.Store.Name, Person.Address.PostalCode, Person.StateProvince.Name as State&#13;&#10;  from Sales.Store join Sales.CustomerAddress on Sales.Store.CustomerID = Sales.CustomerAddress.CustomerID&#13;&#10; join Person.Address on Person.Address.AddressID = Sales.CustomerAddress.AddressID&#13;&#10; join Person.StateProvince on Person.StateProvince.StateProvinceID = Person.Address.StateProvinceID&#13;&#10; where Person.Address.StateProvinceID = @stateid">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="stateid" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <br />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AdventureWorksConnectionString %>"
                SelectCommand="select distinct * from person.stateprovince where countryregioncode = 'US'">
            </asp:SqlDataSource>
            <br />
        </div>
    </form>

    <script type="text/xml-script">
        <page xmlns:script="http://schemas.microsoft.com/xml-script/2005">
            <references>
            </references>
            <components>
            </components>
        </page>
    </script>
</body>
</html>
