<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Ajax and Mapping</title>
    <link href="http://dev.virtualearth.net/standard/v2/MapControl.css" type="text/css" rel="stylesheet" />
    <script src="http://dev.virtualearth.net/standard/v2/MapControl.js" type="text/javascript"></script>
    <style type="text/css" media="screen">
       
            #popup 
            {
              POSITION:absolute;VISIBILITY:hidden;Z-INDEX:199;
            }
            
            .pinConstruction
            {
              cursor:pointer;text-decoration:none;
              z-index:5;
            }
            .pinMinor
            {
              cursor:pointer;text-decoration:none;
              z-index:5;
            }
            .pinModerate
            {
              cursor:pointer;text-decoration:none;
              z-index:5;
            }
            .pinMajor
            {
              cursor:pointer;text-decoration:none;
              z-index:5;
            }            
       
    </style>
<script type="text/javascript" language="javascript">
   var map = null;
   var myPanel;

   function OnPageLoad()
   {

    
        // latitude and longitude have been hard coded	
		var params = new Object();
		params.latitude = 42.42;
		params.longitude = -83.02;
		params.zoomlevel = 10;
		params.mapstyle = Msn.VE.MapStyle.Road;
		params.showScaleBar = false;
		params.showDashboard = true;
		params.dashboardSize = Msn.VE.DashboardSize.Normal;
		params.dashboardX = 5;
		params.dashboardY = 5;
		map = 
			new Msn.VE.MapControl(
				document.getElementById("myMap"), 
				params);
		map.Init()
		PopulateMap();

		
   }

  

    function PopulateMap() 
    {
        // zipcode has been hard coded
	    var zip = "48067";
	    var mapmiles=5;
	    var mapseverity = 0;
	    		 
	    Anthem_InvokePageMethod('PopulateMap',[zip, mapmiles, mapseverity] , CallBack);
	    				
    }	
    function CallBack(result) 
    {
        var table=result.value;	
        var title='';
        var description= '';
        var severity='';
        
        var popstr="";
        var newPushpin = null;
        var categry = '';
        
        for(var i=0;i<table.Rows.length;i++)
        {
		    description = table.Rows[i].description ;
		    description = replaceAll(description, ",", "<br>");
		    severity= table.Rows[i].severity;
		    title=table.Rows[i].title;
		    category = table.Rows[i].category;
	        severity = severity.replace(/^\s*|\s*$/g,"");
		    category = category.replace(/^\s*|\s*$/g,"");
			        
			description = escape(description);
			title = escape(title);
		    switch(category)
			    {case "Construction":
			        var message = '<div><img src=\"pins/dude.gif\"';
			        message +=  'onmouseover=\"popup(\'' + title + '\',\''
			        message += description + '\','+  table.Rows[i].latitude 
			        message += ', ' + table.Rows[i].longitude 
			        message += ')\"; ONMOUSEOUT=\"closePopup()\"; />';
			        message += '</div>';
			        map.AddPushpin('pin' + i, table.Rows[i].latitude, table.Rows[i].longitude, 20, 20, 'pinConstruction', message);
				    break;
			    case "Incident":
				    switch(severity)
				    {
					    case "Minor":

			                var message = '<div><img src=\"pins/minor.gif\"';
			                message +=  'onmouseover=\"popup(\'' + title + '\',\''
			                message += description + '\','+  table.Rows[i].latitude 
			                message += ', ' + table.Rows[i].longitude 
			                message += ')\"; ONMOUSEOUT=\"closePopup()\"; />';
			                message += '</div>';

					        map.AddPushpin('pin' + i, table.Rows[i].latitude, table.Rows[i].longitude, 88, 34, 'pinMinor', message);
						    break;
    					
					    case "Moderate":

			                var message = '<div><img src=\"pins/moderate.gif\"';
			                message +=  'onmouseover=\"popup(\'' + title + '\',\''
			                message += description + '\','+  table.Rows[i].latitude 
			                message += ', ' + table.Rows[i].longitude 
			                message += ')\"; ONMOUSEOUT=\"closePopup()\"; />';
			                message += '</div>';
					    
    					    map.AddPushpin('pin' + i, table.Rows[i].latitude, table.Rows[i].longitude, 88, 34, 'pinModerate', message);
				    	    break;
					    case "Major":
					    
			                var message = '<div><img src=\"pins/major.gif\"';
			                message +=  'onmouseover=\"popup(\'' + title + '\',\''
			                message += description + '\','+  table.Rows[i].latitude 
			                message += ', ' + table.Rows[i].longitude 
			                message += ')\"; ONMOUSEOUT=\"closePopup()\"; />';
			                message += '</div>';

					        map.AddPushpin('pin' + i, table.Rows[i].latitude, table.Rows[i].longitude, 88, 34, 'pinMajor', message);
						    break;
				    }
			    }
         }    
    }
 function replaceAll( str, from, to )
 {
    var newindex = str.indexOf( from );
    while ( newindex > -1 ) 
    {
        str = str.replace( from, to ); 
        newindex = str.indexOf( from );
    }
    return str;
}
  
</script>
</head>
<body onload="OnPageLoad();">
    <form id="form1" runat="server">
        <div id="myMap" style="WIDTH: 600px; HEIGHT: 400px; OVERFLOW:hidden;"></div>
        <div id="popup"></div>	 
	 </form>
	 
<script type="text/javascript">
offX=-20;
offY= 15;
var popupStyle;
var varY=-999;
// browser check variables
var ns4=document.layers;
var ns6=document.getElementById&&!document.all;
var ie4=document.all;
var iex=(document.all);

if (ns4)
{
  popupStyle=document.popup;
}
else if (ns6)
{
  popupStyle=document.getElementById("popup").style;
}
else if (ie4)
{
  popupStyle=document.all.popup.style;
}

if(ns4)
{
  document.captureEvents(Event.MOUSEMOVE);
}
else
{
  popupStyle.visibility="visible";
  popupStyle.display="none";
}



function popup(title, text, latit, longit)
{
   
   text = unescape(text);
   title = unescape(title);
   title = "<strong>" + title + "</strong><br>";
   
   var popHTML="<TABLE  WIDTH=200 BORDER=1 BORDERCOLOR=black CELLPADDING=1 CELLSPACING=0 BGCOLOR=white";
   popHTML += "><TR><TD ALIGN=center><FONT COLOR=black SIZE=2>" + title + text + "</FONT></TD></TR></TABLE>";
   
    var left = map.GetX(longit);
    var top = map.GetY(latit);
    popupStyle.left = left + offX;
    popupStyle.top = top + offY;
    
   if(ns4)
   {
     popupStyle.document.write(popHTML);
     popupStyle.document.close();
     popupStyle.visibility="visible"
   }
   
   if(ns6)
   {
     document.getElementById("popup").innerHTML=popHTML;
     popupStyle.display='';
   }
   
   if(ie4)
   {
     document.all("popup").innerHTML=popHTML;
     popupStyle.display='';
   }
}

function closePopup()
{
    
  varY=-999;
  
  if(ns4)
  {
    popupStyle.visibility="hidden";
  }
  else if (ns6||ie4)
  {
    popupStyle.display="none";
  }
}
</script>
</body>
</html>
