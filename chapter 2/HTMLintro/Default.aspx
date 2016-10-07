<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>My HTML Page</title>
</head>
<body>
    <script type="text/javascript" language="javascript">
        function person(name, country)
        {
            this.name = name;
            this.country = country;
        }
    </script>

    <form id="frmDefault" runat="server">
    <div>
    <script type="text/javascript" language="javascript">
        function sayHello(objPerson)
        {
            return "Hello " + objPerson.name;
        }
              
    </script>
    <h1>Structured Error Handling</h1>
    <br />
    <script type="text/javascript" language="javascript">
        
        var theauthor = new person('Daniel', 'U.S.A.');
        
        try
        {
            document.write( sayHello(theauthor) );
        }
        catch(error)
        {
            document.write ("Error: " + error.value + "<br>");
        }
        finally
        {
            document.write("Hit the Finally block.");
        }
    </script>    
    </div>
    </form>
</body>
</html>
