<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmTaggingSample.aspx.cs" Inherits="frmTaggingSample" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title>Sample Tagging Application</title>
	<script language="javascript" type="text/javascript">
	// Let's establish a placeholder variable for storing the users
	// selected image id here
	var currentImage = null;
	
	function LoadTags(imageID)
	{
	// We'll call our Ajax.Net method within the CSharp file from here
	// and redirect the resulting data to the Callback function.
		Anthem_InvokePageMethod('LoadImageTags',[imageID] , LoadTagsCallBack);
		currentImage = imageID	
	}

	function LoadTagsCallBack(result)
	{
	// Our tags have been loaded and the result.value
	// will contain the HTML table that we build on the
	// code side.  We'll find the DIV tag in the document
	// and then 'bind' the new HTML to the innerHTML
	// property.
		var thisElement = document.getElementById('divTags');
		thisElement.innerHTML = result.value;
	}
	
	function AddTag()
	{
	// We'll store the current image id in the hidden control
	// so that we can demonstrate Page access later.  We'll
	// also use that value for our Insert statement as well.
		var findthis = document.getElementById('hidImageID');
		findthis.value = currentImage;
		
	// we'll add a tag to the images database collection of tags
	// to do that we'll make use of the hidden control's viewstate to
	// store the id of the last image selected.  This will give you a
	// chance to see Ajax.Net's ability to access the Page state.
		var thisElement = document.getElementById('txtTagName');
		Anthem_InvokePageMethod('AddTag',[thisElement.value] , AddTagCallBack);
	}
	
	
	function AddTagCallBack(result)
	{
	// After the tag has been entered we'll come back here for display.
		LoadTags(currentImage);
		
	// Let's remove the users entry from the textbox now that the
	// tag has been entered and posted.
		var findTextBox = document.getElementById('txtTagName');
		findTextBox.value = '';
			
	}
	
	
function DeleteTag(imageID, tagName)
	{
	// We'll allow the user the ability to delete a tag from a particular image.
	// Again we'll need to use the image id stored in the hidden control as a
	// reference for which image to delete against the tagging database.

		var findthis = document.getElementById('hidImageID');
		findthis.value = imageID;

	// Now the call is made to the code side method for deletion.
	// We provide the tag name as the first parameter and the Java side callback
	// function for the return trip.
		Anthem_InvokePageMethod('DeleteTag',[tagName] , DeleteTagCallBack);	
	}
	
	function DeleteTagCallBack(result)
	{
	// After deleting the tag, we'll redisplay the list again.
		LoadTags(currentImage);
	}

	</script>
</head>
	<body>
		<form id="Form1" method="post" runat="server">
	<table style="BORDER-RIGHT: black solid; BORDER-TOP: black solid; BORDER-LEFT: black solid; WIDTH: 336px; BORDER-BOTTOM: black solid; HEIGHT: 414px">
	<tr>
		<td valign="top" align="center">
		
		<div id="divImage1" onmouseover="this.style.cursor='hand';"
            onclick="LoadTags(1);" runat="server">
            <img src="SampleImages\SampleImage1.JPG" alt="SampleImage1" />
        </div>
		
		<div id="divImage2" onmouseover="this.style.cursor='hand';"
            onclick="LoadTags(2);" runat="server">
            <img src="SampleImages\SampleImage2.JPG" alt="SampleImage2" />
        </div>
		
		<div id="divImage3" onmouseover="this.style.cursor='hand';"
            onclick="LoadTags(3);" runat="server">
            <img src="SampleImages\SampleImage3.JPG" alt="SampleImage3" />
        </div>
		
		<div id="divImage4" onmouseover="this.style.cursor='hand';"
            onclick="LoadTags(4);" runat="server">
            <img src="SampleImages\SampleImage4.JPG" alt="SampleImage4" />
        </div>
		
		</td>
		<td valign="top">
		    <table>
		        <tr>
		            <td>
				        <div id="divTags"></div>
			        </td>
		        </tr>
		        <tr>
			    <td align="right"><asp:textbox id="txtTagName" runat="server"
                    Width="96px"></asp:textbox><input onclick="AddTag();"
                    type="button" value="Add" /></td>
		        </tr>
		    </table>
		</td>
	</tr>
	</table>
<input id="hidImageID" type="hidden" name="hidImageID" runat="server" />
		</form>
	</body>
</html>
