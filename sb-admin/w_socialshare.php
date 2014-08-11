	<?php
	session_start();
	include_once 'dbclass/w_dbconfig.php';
	include 'GlobalFunction.php';
	include 'w_dashboardConfig.php';
	$tbl_name="tbl_socialpost"; // Table name

	if(!isset($_SESSION['myusername'])){
	header("Location: http://mymobipoints.com/admin");
	}
	// Connect to server and select databse.
	mysql_connect("$host", "$username", "$password")or die("cannot connect");
	mysql_select_db("$db_name")or die("cannot select DB");

	$sql="SELECT * FROM $tbl_name where isactive='1' ORDER BY addeddate DESC";
	$result=mysql_query($sql);

	$sql1="SELECT * FROM SocialPointsDetails ";
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
				<li class="active"><a href="w_socialshare.php"><i class="fa fa-bar-chart-o"></i> Social Share</a></li> 
				<li><a href="SpinSetting.php"><i class="fa fa-table"></i> Spin Wheel</a></li>
				<li ><a href="NotificationCenter.php"><i class="fa fa-edit"></i> Notifications</a></li>
				<li ><a href="AddNewPackage.php"><i class="fa fa-edit"></i> Package Details</a></li>
				<li ><a href="SalesAndRedemption.php"><i class="fa fa-desktop"></i> Sales & Redemption</a></li>
				<li ><a href="UserList.php"><i class="fa fa-wrench"></i> Users</a></li>
			   <!-- <li><a href="typography.html"><i class="fa fa-font"></i> Typography</a></li>
				<li><a href="bootstrap-elements.html"><i class="fa fa-desktop"></i> Bootstrap Elements</a></li>
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
				<h1><?php echo $appname; ?> <small>Social Share</small></h1>
				<ol class="breadcrumb">
				  <li><a href="w_dashboardhome.php"><i class="fa fa-dashboard"></i> Dashboard</a></li>
				  <li class="active"><i class="fa fa-edit"></i> Social Share</li>
				</ol>
				
			  </div>
			</div><!-- /.row -->
			
			<!-- Top row status --> 
			<div class="row">
			  <div class="col-lg-3">
				<div class="panel panel-info">
				  <div class="panel-heading">
					<div class="row">
					  <div class="col-xs-6">
						<i class="fa fa-comments fa-5x"></i>
					  </div>
					  <div class="col-xs-6 text-right">
						<p class="announcement-heading"><?php echo getTotalNoOfUsers(); ?></p>
						<p class="announcement-text">Total number of users.</p>
					  </div>
					</div>
				  </div>
				  <a href="#">
					<div class="panel-footer announcement-bottom">
					  <div class="row">
						<div class="col-xs-6">
						  Total Users.
						</div>
						<div class="col-xs-6 text-right">
						  <i class="fa fa-arrow-circle-right"></i>
						</div>
					  </div>
					</div>
				  </a>
				</div>
			  </div>
			  <div class="col-lg-3">
				<div class="panel panel-warning">
				  <div class="panel-heading">
					<div class="row">
					  <div class="col-xs-6">
						<i class="fa fa-check fa-5x"></i>
					  </div>
					  <div class="col-xs-6 text-right">
						<p class="announcement-heading"><?php echo getTotalShareDetails(); ?></p>
						<p class="announcement-text">Total number of shares.</p>
					  </div>
					</div>
				  </div>
				  <a href="#">
					<div class="panel-footer announcement-bottom">
					  <div class="row">
						<div class="col-xs-6">
						  Total Shares
						</div>
						<div class="col-xs-6 text-right">
						  <i class="fa fa-arrow-circle-right"></i>
						</div>
					  </div>
					</div>
				  </a>
				</div>
			  </div>
			  <div class="col-lg-3">
				<div class="panel panel-danger">
				  <div class="panel-heading">
					<div class="row">
					  <div class="col-xs-6">
						<i class="fa fa-tasks fa-5x"></i>
					  </div>
					  <div class="col-xs-6 text-right">
						<p class="announcement-heading"><?php echo getTotalRedeemed(); ?></p>
						<p class="announcement-text">Total point redeemed.</p>
					  </div>
					</div>
				  </div>
				  <a href="#">
					<div class="panel-footer announcement-bottom">
					  <div class="row">
						<div class="col-xs-6">
						  Points Redeemed
						</div>
						<div class="col-xs-6 text-right">
						  <i class="fa fa-arrow-circle-right"></i>
						</div>
					  </div>
					</div>
				  </a>
				</div>
			  </div>
			  <div class="col-lg-3">
				<div class="panel panel-success">
				  <div class="panel-heading">
					<div class="row">
					  <div class="col-xs-6">
						<i class="fa fa-comments fa-5x"></i>
					  </div>
					  <div class="col-xs-6 text-right">
						<p class="announcement-heading"><?php echo getTotalOrderedPackage(); ?></p>
						<p class="announcement-text">Total package ordered.</p>
					  </div>
					</div>
				  </div>
				  <a href="#">
					<div class="panel-footer announcement-bottom">
					  <div class="row">
						<div class="col-xs-6">
						  Package Ordered
						</div>
						<div class="col-xs-6 text-right">
						  <i class="fa fa-arrow-circle-right"></i>
						</div>
					  </div>
					</div>
				  </a>
				</div>
			  </div>
			</div><!-- /. end of top row status -->
			
			
			<h4 >Simply edit the point value you wish to reward for each social media share by clicking edit below. </h4>
			
			<br />
						<div class="table-responsive"><!-- End of Social weight div -->
							<table class="table table-hover tablesorter">
								<thead>
									<tr>   
										<th class="span3" colspan="1">
											<span class="line"></span>Facebook Points
										</th>
										<th class="span6" colspan="1">
											<span class="line"></span>Twitter Points
										</th>
										<th class="span3" colspan="1">
											<span class="line"></span>Instagram Points
										</th>
										 <th class="span6" colspan="1">
											<span class="line"></span>Foursquare Points
										</th>
										<th class="span6" colspan="1">
											<span class="line"></span>Action
										</th>
										
									</tr>
								</thead>
								<tbody>
									
	<?php
	$counter=0;
	$colorCode="";
	while($tableName1 = mysql_fetch_row($result1)) {
	$column1=$tableName1[0];
	$column2=$tableName1[1];
	$column3=$tableName1[2];
	$column4=$tableName1[3];
	$voucherValue=0;

	echo '<tr class="warning"><td width=25% ><img src="image/fb_icon.png" /> &nbsp;&nbsp;'.$column1.' Points</td><td width=25% align="left" style=" color:#333333;"><img src="image/tw_icon.png" /> &nbsp;&nbsp;'.$column2.' Points</td><td width=25% style=" color:#333333;"><img src="image/ista_icon.png" /> &nbsp;&nbsp;'.$column3.' Points</td><td width=25% style=" color:#333333;"><img src="image/square_icon.png" /> &nbsp;&nbsp;'.$column4.' Points</td><td><input type="button" value="Edit" id="UpdateBtn" class="btn btn-primary" onclick="UpdateButtonClicked();" /></td></tr>';

	}

	?>
								</tbody>
							</table>
						</div><!-- End of Social weight div -->

				<div class="row" id="UpdateDiv"><!-- Social form div -->
				<div class="col-lg-12">
			   <form enctype="multipart/form-data" role="form" id="socialpointform" action="UpdateSocialPoints.php" method="post" >
			   <div class="form-group">
                <label>Facebook Points</label>
                <input class="form-control" type="text" id='Point1' name="Point1">
                <p class="help-block">Point value should be number. This point will be awarded to user once the share post will be approved by admin .</p>
               </div>
			   
			   <div class="form-group">
                <label>Twitter Points</label>
                <input class="form-control" type="text" id='Point2' name="Point2">
                <p class="help-block">Point value should be number. This point will be awarded to user once the tweet will be approved by admin .</p>
               </div>
			   
			   <div class="form-group">
                <label>Instagram Points</label>
                <input class="form-control" type="text" id='Point3' name="Point3">
                <p class="help-block">Point value should be number. This point will be awarded to user once the shared photo will be approved by admin .</p>
               </div>
			   
			   <div class="form-group">
                <label>Foursquare Points</label>
                <input class="form-control" type="text" id='Point4' name="Point4">
                <p class="help-block">Point value should be number. This point will be awarded to user once the check-in will be approved by admin .</p>
               </div>
				<input type="button" onclick="submitPointUpdateClicked()" value="Submit" class="btn btn-success" /><span>&nbsp;&nbsp;<input type="button" class="btn btn-danger"  value="CANCEL" onclick="CancelButtonClicked();"/></span>
				</form>
				</div>
				</div><!-- End of Social form div -->
				
<div class="row"><!-- Start Main container sample -->
<div class="col-lg-12">  <!--Add new Package container -->
 <h4>Add New Social Content to your App </h4>
 <hr />
<form enctype="multipart/form-data" action="SocialShareDB.php" id="socialshareform" method="post">
<h5>Please select the category from dropdown:&nbsp;&nbsp;&nbsp;&nbsp;</h5><select id="orderdropdown" name="orderdropdown" onchange="socialShareDropDown();" class="form-control">
<option value="select1"> Select</option>
<option value="Coupon"> Coupon</option>
<option value="Picture"> Picture</option>
<option value="Blog"> Blog</option>
<option value="Text"> Text</option>
<option value="Video"> Video</option>
<option value="Podcast"> Podcast</option>
</select>

<!-- Coupon Block div -->
<div id="contentDiv" style="width:100%; height:auto; border:2px; visibility:visible; display:block;">

</div>

<!-- End of Coupon Block div -->

</form>

</div><!--End of Add new package container -->

</div><!-- end Main container sample -->						
						
			<div class="row">
			  <div class="col-lg-12">
				<h2>Social Share Details</h2>
				<div class="table-responsive">
					<table class="table table-hover tablesorter">
							   <thead>
									<tr>
										<th class="span3" colspan="1">
											Index
										</th>
										<th class="span6" colspan="1">
											<span class="line"></span>Title
										</th>
										<th class="span3" colspan="1">
											<span class="line"></span>Description
										</th>
										 <th class="span6" colspan="1">
											<span class="line"></span>Link
										</th>
										<th class="span6" colspan="2">
											<span class="line"></span>Added Date
										</th>
									</tr>
								</thead>
								<tbody>
									
	<?php
	$counter=0;
	$index=1;
	$colorCode="";
	while($tableName = mysql_fetch_row($result)) {

	if($counter%2==0){
	$colorCode="#f7f7f7";
	}
	else{
	$colorCode="#ffffff";
	}
	$counter++;
	$shareDesc="";
	$shareImgName=""; 

	echo '<tr style="background-color:'.$colorCode.'"><td width=5% style="padding-left:10px;">'.$index.'</td><td width=15% >'.$tableName[1].'&nbsp;&nbsp;</td><td width=30%>'.$tableName[2].'</td><td width=10%><a href="'.$tableName[5].'" target="_blank" >Social Link</a></td><td width=10%>'.date("m-d-Y", strtotime($tableName[4])).'</td><td width=5%><input type="button" value="Edit" class="btn btn-warning"  onclick="EditClicked(\''.$tableName[0].'\',\''.$tableName[15].'\')"></td><td width=5%><input type="button" value="Delete" class="btn btn-danger"  onclick="DeleteClicked(\''.$tableName[0].'\')"></td></tr>';

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