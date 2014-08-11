<?php
session_start();
include_once 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="userdetail"; // Table name
include 'w_dashboardConfig.php';

if(!isset($_SESSION['myusername'])){
header("Location: ".$adminLoginPath);
}
// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$sql="SELECT * FROM $tbl_name where userid='".$_GET['userid']."'";
$result=mysql_query($sql);
//echo $result;
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
			    <li ><a href="SalesAndRedemption.php"><i class="fa fa-desktop"></i> Sales & Redemption</a></li>
			    <li class="active"><a href="UserList.php"><i class="fa fa-file"></i> Users</a></li>
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
				<h1><?php echo $appname; ?> <small>Bonus</small></h1>
				<ol class="breadcrumb">
				  <li><a href="w_dashboardhome.php"><i class="fa fa-dashboard"></i> Dashboard</a></li>
				  <li class="active"><i class="fa fa-edit"></i> Bonus</li>
				</ol>
				
			  </div>
			</div><!-- /.row -->
			
			<br />

			<?php $tableName = mysql_fetch_row($result) ; ?>
			<h4>User Name : <small><?php echo $tableName[11].' '.$tableName[12]; ?></small></h4>
			<h4>Currently Total Point : <small><?php echo getTotalAccountPointsData($tableName[0]); ?></small></h4>
			<h4>Points Redeemed : <small><?php echo getTotalRedeemedData($tableName[0]); ?></small></h4>
			<br />
                
                <h3>Reward Bonus Point</h3>
                <div class="row" id="UpdateDiv"><!-- Social form div -->
				<div class="col-lg-6">
                <div class="form-group">
				<form action="BonusPointDB.php" id="bonusPointForm" method="post" enctype="multipart/form-data" >
				<input class="form-control" type="hidden" value="<?php echo $_GET['userid']; ?>" name="userid"/>
				<input class="form-control" type="text" placeholder="Bonus Point" name="point" height=30px />
				<br />
				<input type="button" value="SUBMIT" class="btn btn-success" onclick="submitBonusButtonClicked()" value="Submit" />
				</form>
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
		$(document).ready(function(){
		//Social share post form
$("#bonusPointForm").submit(function(e)
{
	//alert('2');
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
					window.history.back();
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

function submitBonusButtonClicked()
{	//alert('1');
	$("#bonusPointForm").submit();
}
		
		</script>
	</html>