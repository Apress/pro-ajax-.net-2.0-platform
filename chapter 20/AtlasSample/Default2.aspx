<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
       <atlas:ScriptManager ID="atlasSM" runat="server"></atlas:ScriptManager>
        
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <input id="TextBox1" type="text" style="width: 240px" />
    </div>
    </form>
     <script type="text/xml-script">
        <page xmlns:script="http://schemas.microsoft.com/xml-script/2005">
          <components>
              <textBox id="TextBox1">
                  <behaviors>
                      <autoComplete 
                        serviceURL="wsGetStoreNames.asmx" 
                        serviceMethod="GetNames"
                        minimumPrefixLength="1" 
                        completionSetCount="8" 
                        completionInterval="200" />
                  </behaviors>
              </textBox>
          </components>
        </page>
    </script>

</body>
</html>
