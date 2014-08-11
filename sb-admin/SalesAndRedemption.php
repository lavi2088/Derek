	<?php
session_start();
include_once 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="MonthlyPackageUsers"; // Table name
include 'w_dashboardConfig.php';

if(!isset($_SESSION['myusername'])){
header("Location: ".$adminLoginPath);
}
// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$sql="SELECT * FROM $tbl_name where pkgType='M' ORDER BY startdate DESC";
$result=mysql_query($sql);

$sql1="SELECT * FROM $tbl_name where pkgType='N' OR  pkgType='V' ORDER BY startdate DESC";
$result1=mysql_query($sql1);

$errorMsg='';
if(isset($_GET['error']))
{
$errorMsg=$_GET['msg'];
}
?>
	<!DOCTYPE html>
	<html lang="en">
	  <head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">

		<title><?php echo $appname; ?> - Social Share</title>

		<!-- Bootstrap core CSS -->
		<link href="css/bootstrap.css" rel="stylesheet">

		<!-- Add custom CSS here -->
		<link href="css/sb-admin.css" rel="stylesheet">
		<link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
		<link href="css/additionalStyle.css" rel="stylesheet" type="text/css">
		
		 <!-- knob -->
		<script src="js/jquery.knob.js"></script>
		<script type="text/javascript" src="js/jscolor.js"></script>
	  </head>
	  
	  <body>

		<div id="wrapper">

		  <!-- Sidebar -->
		  <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
			  <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			  </button>
			  <a class="navbar-brand" href="w_dashboardhome.php"><?php echo $appname; ?> Admin</a>
			</div>

			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse navbar-ex1-collapse">
			  <ul class="nav navbar-nav side-nav">
				<li ><a href="w_dashboardhome.php"><i class="fa fa-dashboard"></i> Home</a></li>
				<li ><a href="w_socialshare.php"><i class="fa fa-bar-chart-o"></i> Social Share</a></li> 
				<li><a href="SpinSetting.php"><i class="fa fa-table"></i> Spin Wheel</a></li>
				<li ><a href="NotificationCenter.php"><i class="fa fa-edit"></i> Notifications</a></li>
				<li ><a href="AddNewPackage.php"><i class="fa fa-edit"></i> Package Details</a></li>
			    <li class="active"><a href="SalesAndRedemption.php"><i class="fa fa-desktop"></i> Sales & Redemption</a></li>
			    <li ><a href="UserList.php"><i class="fa fa-wrench"></i> Users</a></li>
				<!--<li><a href="bootstrap-elements.html"><i class="fa fa-desktop"></i> Bootstrap Elements</a></li>
				<li><a href="bootstrap-grid.html"><i class="fa fa-wrench"></i> Bootstrap Grid</a></li>
				<li><a href="blank-page.html"><i class="fa fa-file"></i> Blank Page</a></li>
				<li class="dropdown">
				  <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-caret-square-o-down"></i> Dropdown <b class="caret"></b></a>
				  <ul class="dropdown-menu">
					<li><a href="#">Dropdown Item</a></li>
					<li><a href="#">Another Item</a></li>
					<li><a href="#">Third Item</a></li>
					<li><a href="#">Last Item</a></li>
				  </ul>
				</li> -->
			  </ul>
			</div><!-- /.navbar-collapse -->
		  </nav>

		  <div id="page-wrapper">
		  
		  <div class="row">
			  <div class="col-lg-12">
				<h1><?php echo $appname; ?> <small>Sales</small></h1>
				<ol class="breadcrumb">
				  <li><a href="w_dashboardhome.php"><i class="fa fa-dashboard"></i> Dashboard</a></li>
				  <li class="active"><i class="fa fa-edit"></i> Sales & Redemption</li>
				</ol>
				
			  </div>
			</div><!-- /.row -->
						
						
			<div class="row">
			  <div class="col-lg-12">
				<h2>Sales and Redemption Details</h2>
				<div class="table-responsive">
					<table class="table table-hover tablesorter">
							   <thead>
                                <tr>
                                    <th class="span1" colspan="1">
                                        Index
                                    </th>
                                    <th class="span2" colspan="1">
                                        <span class="line"></span>User Name
                                    </th>
                                    <th class="span2" colspan="1">
                                        <span class="line"></span>Title
                                    </th>
									 <th class="span3" colspan="1">
                                        <span class="line"></span>Description
                                    </th>
									<th class="span1" colspan="1">
                                        <span class="line"></span>Points
                                    </th>
									<th class="span1" colspan="1">
                                        <span class="line"></span>Amount
                                    </th>
									<th class="span1" colspan="1">
                                        <span class="line"></span>Redeemed Date
                                    </th>
                                    <th class="span1" colspan="1">
                                        <span class="line"></span>PIN
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
								
<?php
$counter=0;
$index=1;
$colorCode="";
while($tableName = mysql_fetch_row($result1)) {

if($counter%2==0){
$colorCode="#f7f7f7";
}
else{
$colorCode="#ffffff";
}
$counter++;
$shareDesc="";
$shareImgName="";

echo '<tr style="background-color:'.$colorCode.'"><td width=5% style="padding-left:10px;">'.$index.'</td><td width=10% align="right">'.$tableName[1].' '.$tableName[2].'&nbsp;&nbsp;</td><td width=20%>'.$tableName[3].'</td><td width=25%>'.$tableName[4].'</td><td width=10%>'.$tableName[8].' Points</td><td width=10%>$'.$tableName[7].'</td><td width=10%>'.date("m-d-Y", strtotime($tableName[5])).'</td><td width=10%>'.$tableName[10].'</td></tr>';

++$index; 
}

?>
                            </tbody>
							</table>
				</div>
			  </div>
			</div>

		  </div><!-- /#page-wrapper -->

		</div><!-- /#wrapper -->

		<!-- JavaScript -->
		<script src="js/jquery-1.10.2.js"></script>
		<script src="js/bootstrap.js"></script>

	  </body>
		
		<script type="text/javascript">
		
		function EditClicked(pkgId,category){
			//alert(pkgId);
			window.location.href='SocialShareEdit.php?socialid='+pkgId+'&category='+category;
	}
	function DeleteClicked(pkgId){
			//alert(pkgId+"delete");
			window.location.href='SocialShareDelete.php?id='+pkgId;
	}
	
function loadDefaultValue(){
  document.getElementById('UpdateDiv').hidden=true;
  }
	function UpdateButtonClicked(){
		$('#UpdateDiv').fadeIn("slow");
	}
	
	function CancelButtonClicked(){
		$('#UpdateDiv').fadeOut("slow");
	}
	
	function socialShareDropDown(){
	
		var selectedVal=document.getElementById("orderdropdown").value;
		if(selectedVal=="Coupon"){
			var addPicker='<h4>Coupon Block</h4><hr /> ';
			var tableContent=addPicker+' <input type="hidden" name="category" value="coupon"><div class="form-group"><div class="row"><div class="col-lg-2">Choose Logo:</div><div class="col-lg-3"><input type="file" rel="txtTooltip" title="Please select image size of 200x200 px." name="logofile" id="logofile" ></div></div></div>  '+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Choose Image:</div><div class="col-lg-3"><input type="file" rel="txtTooltip" title="Please select image size of 600x200 px." name="file" id="file" onchange="readURL(this);"></div></div></div>'+
			' <div class="form-group"><div class="row"><div class="col-lg-2">Coupon Title:</div><div class="col-lg-3"><input type="text" class="form-control" name="title" id="title" onChange="socialTitleChange();" placeholder="Title"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Description:</div><div class="col-lg-3"><textarea class="form-control" name="desc" id="desc" rows=7 cols=80 onChange="socialDescChange();" placeholder="Description" ></textarea></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">% Savings:</div><div class="col-lg-3"><input class="form-control" type="text" id="savingper" name="savingper"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Enter Point Value:</div><div class="col-lg-3"><input class="form-control" type="text" id="pointval" name="pointval"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Enter Coupon Amount:</div><div class="col-lg-3"><input class="form-control" type="text" id="amountval" name="amountval"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Tags:</div><div class="col-lg-3"><input class="form-control" type="text" id="tags" name="tags"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Color:</div><div class="col-lg-3"><input class="color" name="colorcode" value="c11629"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Send Notification:</div><div class="col-lg-3"><input type="checkbox" id="noticheckbox" name="noticheckbox"></div></div></div>';	
			var expiredays='<div class="form-group"><div class="row"><div class="col-lg-2">Valid till:</div><div class="col-lg-3"><select class="form-control" name="expiredays"><option value="1">&nbsp;&nbsp;1 day</option><option value="7">&nbsp;&nbsp;1 week</option><option value="30">&nbsp;&nbsp;1 month</option></select></div></div></div>'+
			'<br /><input type="button" onclick="submitSocialShareClicked()" value="Submit" class="btn btn-success"> ';
			document.getElementById("contentDiv").innerHTML=tableContent+" "+expiredays;
			jscolor.init();
			
		}
		else if(selectedVal=="Picture"){
			document.getElementById("contentDiv").innerHTML='<input type="hidden" name="category" value="picture"><h4>Picture Block</h4><hr />'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Upload Image:</div><div class="col-lg-3"><input type="file" rel="txtTooltip" title="Please select image size of 600x400 px." name="file" id="file" onchange="readURL(this);"></div></div></div> '+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Title:</div><div class="col-lg-3"><input type="text" class="form-control" name="title" id="title" onChange="socialTitleChange();" placeholder="Title"> </div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Description:</div><div class="col-lg-3"><textarea name="desc" class="form-control" id="desc" rows=7 cols=80 onChange="socialDescChange();" placeholder="Description" ></textarea></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Enter Point Value:</div><div class="col-lg-3"><input type="text" class="form-control" id="pointval" name="pointval"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Tags:</div><div class="col-lg-3"><input type="text" id="tags" class="form-control" name="tags"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">URL:</div><div class="col-lg-3"><input type="text" class="form-control" id="link" name="link"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Send Notification:</div><div class="col-lg-3"><input type="checkbox" id="noticheckbox" name="noticheckbox"></div></div></div>'+
			'<br /><input type="button" onclick="submitSocialShareClicked()" value="Submit" class="btn btn-success"><!-- End of Picture Block div -->';
		}
		else if(selectedVal=="Blog"){
			document.getElementById("contentDiv").innerHTML='<input type="hidden" name="category" value="blog"><h4>Blog Block</h4><hr />'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Upload Image:</div><div class="col-lg-3"><input type="file" name="file" id="file" rel="txtTooltip" title="Please select image size of 600x400 px." onchange="readURL(this);"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Blog Title:</div><div class="col-lg-3"><input type="text" class="form-control" name="title" id="title" onChange="socialTitleChange();" placeholder="Title"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Description:</div><div class="col-lg-3"><textarea class="form-control" name="desc" id="desc" rows=7 cols=80 onChange="socialDescChange();" placeholder="Description" ></textarea></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Enter Point Value:</div><div class="col-lg-3"><input type="text" class="form-control" id="pointval" name="pointval"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Writer name:</div><div class="col-lg-3"><input type="text" class="form-control" id="writername" name="writername"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Tags:</div><div class="col-lg-3"><input type="text" class="form-control" id="tags" name="tags"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">URL:</div><div class="col-lg-3"><input type="text" class="form-control" id="link" name="link"></div></div></div>'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Send Notification:</div><div class="col-lg-3"><input type="checkbox" id="noticheckbox" name="noticheckbox"></div></div></div>'+
			'<input type="button" value="Submit" onclick="submitSocialShareClicked()" class="btn btn-success"><!-- End of Blog Block div -->';
		}
		else if(selectedVal=="Text"){
			document.getElementById("contentDiv").innerHTML='<input type="hidden" name="category" value="text">';
		}
		else if(selectedVal=="Video"){
			document.getElementById("contentDiv").innerHTML='<input type="hidden" name="category" value="video"><h4>Video Block</h4><hr />'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Video Title:</div><div class="col-lg-3"><input type="text" class="form-control" name="title" id="title" onChange="socialTitleChange();" '+
			'></div></div></div>   <div class="form-group"><div class="row"><div class="col-lg-2">Video Link:</div><div class="col-lg-3"><input type="text" class="form-control" name="link" id="link" '+
			'onChange="socialTitleChange();" ></div></div></div>  <div class="form-group"><div class="row"><div class="col-lg-2">Enter Point Value:</div><div class="col-lg-3">'+
			'<input type="text" id="pointval" class="form-control" name="pointval"></div></div></div>  <div class="form-group"><div class="row"><div class="col-lg-2">Tags:</div><div class="col-lg-3"><input type="text" class="form-control" id="tags" '+
			'name="tags"></div></div></div>    <div class="form-group"><div class="row"><div class="col-lg-2">Send Notification:</div> <div class="col-lg-3"> <input type="checkbox" id="noticheckbox" name="noticheckbox">'+
			'</div></div></div><br /><input type="button" onclick="submitSocialShareClicked()" value="Submit" class="btn btn-success"><!-- End of Blog Block div -->';
		}
		else if(selectedVal=="Podcast"){
			document.getElementById("contentDiv").innerHTML='<input type="hidden" name="category" value="podcast"><h4>Podcast Block</h4><hr />'+
			'<div class="form-group"><div class="row"><div class="col-lg-2">Podcast Title:</div><div class="col-lg-3"><input type="text" class="form-control" name="title" id="title" onChange="socialTitleChange();" '+
			'></div></div></div> <div class="form-group"><div class="row"><div class="col-lg-2">Podcast Link:</div><div class="col-lg-3"><input type="text" class="form-control" name="link" id="link" '+
			'onChange="socialTitleChange();" ></div></div></div>  <div class="form-group"><div class="row"><div class="col-lg-2">Enter Point Value:</div>'+
			'<div class="col-lg-3"><input type="text" id="pointval" class="form-control" name="pointval"></div></div></div>  <div class="form-group"><div class="row"><div class="col-lg-2">Tags:</div><div class="col-lg-3"><input type="text" class="form-control" id="tags" name="tags"></div>'+
			'</div></div>  <div class="form-group"><div class="row"><div class="col-lg-2">Send Notification:</div><div class="col-lg-3"><input type="checkbox" id="noticheckbox" name="noticheckbox"></div></div></div>'+
			'<br /><input type="button" onclick="submitSocialShareClicked()" value="Submit" class="btn btn-success"><!-- End of Blog Block div -->';
		}
		else if(selectedVal=="select"){
			document.getElementById("contentDiv").innerHTML='<input type="hidden" name="category" value="select">';
		}
		$('input[rel="txtTooltip"]').tooltip();
	}
	
	loadDefaultValue(); 
	
	//Jquery block
	$(document).ready(function(){
	
	$('input[rel="txtTooltip"]').tooltip();
	
	$("#socialpointform").submit(function(e)
{
	var formObj = $(this);
	var formURL = formObj.attr("action");

	if(window.FormData !== undefined)  // for HTML5 browsers
	{
	
		var formData = new FormData(this);
		$.ajax({
        	url: formURL,
			type: "POST",
			data:  formData,
			mimeType:"multipart/form-data",
			contentType: false,
    	    cache: false,
			processData:false,
			success: function(data, textStatus, jqXHR)
		    {
				var obj = jQuery.parseJSON( data );
				if(obj.responsestatus==1)
				{
					alert(obj.msg);
					location.reload();
				}
				else{
					alert(obj.msg);
				}
		    },
		  	error: function(jqXHR, textStatus, errorThrown) 
	    	{
				alert(textStatus);
	    	} 	        
	   });
        e.preventDefault();
   }
   else  //for olden browsers
	{
		//generate a random id
		var  iframeId = "unique" + (new Date().getTime());

		//create an empty iframe
		var iframe = $('<iframe src="javascript:false;" name="'+iframeId+'" />');

		//hide it
		iframe.hide();

		//set form target to iframe
		formObj.attr("target",iframeId);

		//Add iframe to body
		iframe.appendTo("body");
		iframe.load(function(e)
		{
			var doc = getDoc(iframe[0]);
			var docRoot = doc.body ? doc.body : doc.documentElement;
			var data = docRoot.innerHTML;
			//data return from server.
			
		});
	
	}

});

//Social share post form
$("#socialshareform").submit(function(e)
{
	var formObj = $(this);
	var formURL = formObj.attr("action");

	if(window.FormData !== undefined)  // for HTML5 browsers
	{
	
		var formData = new FormData(this);
		$.ajax({
        	url: formURL,
			type: "POST",
			data:  formData,
			mimeType:"multipart/form-data",
			contentType: false,
    	    cache: false,
			processData:false,
			success: function(data, textStatus, jqXHR)
		    {
				var obj = jQuery.parseJSON( data );
				if(obj.responsestatus==1)
				{
					alert(obj.msg);
					location.reload();
				}
				else{
					alert(obj.msg);
				}
		    },
		  	error: function(jqXHR, textStatus, errorThrown) 
	    	{
				alert(textStatus);
	    	} 	        
	   });
        e.preventDefault();
   }
   else  //for olden browsers
	{
		//generate a random id
		var  iframeId = "unique" + (new Date().getTime());

		//create an empty iframe
		var iframe = $('<iframe src="javascript:false;" name="'+iframeId+'" />');

		//hide it
		iframe.hide();

		//set form target to iframe
		formObj.attr("target",iframeId);

		//Add iframe to body
		iframe.appendTo("body");
		iframe.load(function(e)
		{
			var doc = getDoc(iframe[0]);
			var docRoot = doc.body ? doc.body : doc.documentElement;
			var data = docRoot.innerHTML;
			//data return from server.
			
		});
	
	}

});

});

function submitPointUpdateClicked()
{
	$("#socialpointform").submit();
}

function submitSocialShareClicked()
{
	$("#socialshareform").submit();
}
		</script>
	</html>