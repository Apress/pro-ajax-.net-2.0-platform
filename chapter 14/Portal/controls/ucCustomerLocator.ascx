<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucCustomerLocator.ascx.cs" Inherits="controls_ucCustomerLocator" %>
<style type="text/css">
     .mouseOut{ background: #ccccff; color: #0000000; }
	 .mouseOver{ background: #FFFAFA; color: #0000000; }
</style>

<script type="text/javascript" language="javascript">
var ClientID = "";

function ShowDiv(divid)
{
   if (document.layers) document.layers[divid].visibility="show";
   else document.getElementById(divid).style.visibility="visible";
}

function HideDiv(divid)
{
   if (document.layers) document.layers[divid].visibility="hide";
   else document.getElementById(divid).style.visibility="hidden";
}

function BodyStart()
{
    // Populate a customer map
    StarterMap();
    
    HideDiv(ClientID + "searchresults");
    
    // set focus to the input box
	var findtextbox = document.getElementById(ClientID + "keyword");
	findtextbox.focus();
	
}
function ClearResults()
{   
	// remove existing rows in results table
	var resultsdiv = document.getElementById(ClientID + "searchresults");
	var counter = resultsdiv.childNodes.length;
	for (var i = counter -1; i >= 0; i--)
	{
		resultsdiv.removeChild(resultsdiv.childNodes[i]);
	}
}

function LoadResults(searchterm)
{
	if (searchterm.length == 0)
	{
		// if the input box is empty let's dump all the rows from the results table
		ClearResults();
		HideDiv(ClientID + "searchresults");
		return;
	}

	// fetch results from server side
	// this is our actual ajax call
    Anthem_InvokeControlMethod(
          "<%= ClientID %>" , 
          'RetrieveRows', 
          [searchterm], 
          LoadResultsCallback);
    
}

function LoadResultsCallback(result)
{
	// the xmlhttprequest will return to this function.
	ShowDiv(ClientID + "searchresults");
	ClearResults();
	
	// callback results from Ajax call
	// we'll assign the inbound DataTable
	// to the items variable
	var items = result.value;
	
	var count = items.Rows.length;
	
	// we'll create a table object in the DOM
	var divResults = document.getElementById(ClientID + "searchresults");
	var tblTable = document.createElement("table");
	var tablebody = document.createElement("tbody");
	var tablerow, tablecell, tablenode;
	
	// loop through each of the rows in the DataTable
	for (var i = 0; i < count; i++)
	{
	    var zip = items.Rows[i].PostalCode;
		var currenttext = items.Rows[i].Name + ": " + items.Rows[i].State;
		
		// we'll create each table row and append it to the
		// table body
		tablerow = document.createElement("tr");
		tablecell = document.createElement("td");
			// build the cell attributes and functions
		tablecell.onmouseover = function(){this.className='mouseOver';};
		tablecell.onmouseout = function(){this.className='mouseOut';};
		tablecell.setAttribute("border", "0");
		
		// lets store the zip code in the ID field of the tablecell
		// so that we can simply pass the table cell on the click event.
		tablecell.ID = zip;
		
		tablecell.onclick =  function(){ReplaceInput(this);};
		tablenode = document.createTextNode(currenttext);
		tablecell.appendChild(tablenode);
		tablerow.appendChild(tablecell);
		tablebody.appendChild(tablerow);
	}
	// add the table body to the table
	tblTable.appendChild(tablebody);
	// add the table to the div tag
	divResults.appendChild(tblTable);
}

function ReplaceInput(tablecell)
{
    // grab the zipcode out of the table cells ID field.
    var zipcode = tablecell.ID;

    // save the zipcode in a hidden control for retrieval
    var hidField = document.getElementById(ClientID + "hidZipCode")
    hidField.value = zipcode;
    Anthem_InvokeControlMethod(
          "<%= ClientID %>",
          'GetMapUrl', 
          [zipcode], 
          displayMap);

	// Replace textbox value with the assembled text.
	var inputbox = document.getElementById(ClientID + "keyword");
	inputbox.value = tablecell.firstChild.nodeValue;
	ClearResults();
	HideDiv(ClientID + "searchresults");
}

function displayMap(results)
{
    document.getElementById(ClientID + "divStoreMap").innerHTML = results.value;
}

function StarterMap()
{
    var zip ="";
    
    // lets grab any existing zip code from the hidden field.
    var hidZipCode = document.getElementById(ClientID + "hidZipCode").value;
    if(hidZipCode.length > 0)
    {
        zip = hidZipCode;
    }
    else
    {
        zip = '49503';
    }
    //GetMapUrl
    Anthem_InvokeControlMethod(
          "<%= ClientID %>",
          'GetMapUrl', 
          [zip], 
          displayMap);

}

</script>
<div id="divStoreMap" runat="server"></div>
<strong>Search:</strong><br />
<input name="keyword" onkeyup="LoadResults(this.value)" id="keyword" runat="server" style="WIDTH:310px" autocomplete="off" />
<div class="box" id="searchresults" runat="server" style="WIDTH:310px;BACKGROUND-COLOR:#ccccff">
</div>
<input id="hidZipCode" type="hidden" runat="server" />