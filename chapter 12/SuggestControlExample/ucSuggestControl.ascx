<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucSuggestControl.ascx.cs" Inherits="ucSuggestControl" %>
<style type="text/css"> .mouseOut{ background: #ccccff; color: #0000000; }
	.mouseOver{ background: #FFFAFA; color: #0000000; }
</style>

<script type="text/javascript">
var ClientID;

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

function BodyLoad()
{
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
        "<%= ClientID %>",
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
		var currenttext = items.Rows[i].Name;
		
		// we'll create each table row and append it to the
		// table body
		tablerow = document.createElement("tr");
		tablecell = document.createElement("td");
			// build the cell attributes and functions
		tablecell.onmouseover = function(){this.className='mouseOver';};
		tablecell.onmouseout = function(){this.className='mouseOut';};
		tablecell.setAttribute("border", "0");
		tablecell.onclick = function(){ReplaceInput(this);};
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
	// swap Input box value with the value selected by
	// the users mouse click
	var inputbox = document.getElementById(ClientID + "keyword");
	inputbox.value = tablecell.firstChild.nodeValue;
	ClearResults();
	HideDiv(ClientID + "searchresults");
}
</script>

<strong>Search:</strong>
<input name="keyword" onkeyup="LoadResults(this.value)" id="keyword" runat="server" style="WIDTH:500px" />
<div align="left" class="box" id="searchresults" runat="server" style="WIDTH:500px;BACKGROUND-COLOR:#ccccff">
</div>
