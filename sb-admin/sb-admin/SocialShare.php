<?php
session_start();
include_once 'dbconfig.php';
include 'GlobalFunction.php';
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
<html>
<head>
	<title>Detail Admin - Home</title>
	<meta http-equiv="refresh" content="1000">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<!-- scripts -->
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery-ui-1.10.2.custom.min.js"></script>
    <!-- knob -->
    <script src="js/jquery.knob.js"></script>
	<script type="text/javascript" src="js/jscolor.js"></script>
	
    <!-- bootstrap -->
    <link href="css/bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="css/bootstrap/bootstrap-responsive.css" rel="stylesheet" />
    <link href="css/bootstrap/bootstrap-overrides.css" type="text/css" rel="stylesheet" />

    <!-- libraries -->
    <link href="css/lib/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
    <link href="css/lib/font-awesome.css" type="text/css" rel="stylesheet" />

    <!-- global styles -->
    <link rel="stylesheet" type="text/css" href="css/layout.css">
    <link rel="stylesheet" type="text/css" href="css/elements.css">
    <link rel="stylesheet" type="text/css" href="css/icons.css">
    
    <!-- this page specific styles -->
    <link rel="stylesheet" href="css/compiled/index.css" type="text/css" media="screen" />    
    <link rel="stylesheet" type="text/css" href="css/skins/dark.css">
    <!-- open sans font -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>

    <!-- lato font -->
    <link href='http://fonts.googleapis.com/css?family=Lato:300,400,700,900,300italic,400italic,700italic,900italic' rel='stylesheet' type='text/css'>
	
	<link href="css/additionalStyle.css" rel="stylesheet" type="text/css">
	
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
	
	<link href="popup/popup.css" rel="stylesheet" type="text/css" media="all" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"> </script>
	<script type="text/javascript" src="popup/popup.js"></script>

	<style>
	
	

	</style>
</head>
<body>

    <!-- navbar -->
    <div class="navbar navbar-inverse">
        <div class="navbar-inner">
            <button type="button" class="btn btn-navbar visible-phone" id="menu-toggler">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            
            <a class="brand" href="index.html"><img src="img/logo.png"></a>

            <ul class="nav pull-right">                
                <li class="hidden-phone">
                    <input class="search" type="text" />
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle hidden-phone" data-toggle="dropdown">
                        Your account
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="personal-info.html">Personal info</a></li>
                        <li><a href="#">Account settings</a></li>
                        <li><a href="#">Billing</a></li>
                        <li><a href="#">Export your data</a></li>
                        <li><a href="#">Send feedback</a></li>
                    </ul>
                </li>
                <li class="settings hidden-phone">
                    <a href="personal-info.html" role="button">
                        <i class="icon-cog"></i>
                    </a>
                </li>
                <li class="settings hidden-phone">
                    <a href="signin.html" role="button">
                        <i class="icon-share-alt"></i>
                    </a>
                </li>
            </ul>            
        </div>
    </div>
    <!-- end navbar -->

    <!-- sidebar -->
    <div id="sidebar-nav">
        <ul id="dashboard-menu">
            <li >
                <a href="PostHome.php">
                    <i class="icon-home"></i>
                    <span>Home</span>
                </a>
            </li>            
            <li>
                <a href="Chart.php">
                    <i class="icon-signal"></i>
                    <span>Charts</span>
                </a>
            </li>
			<li>
                <a href="SalesAndRedemption.php">
                    <i class="icon-edit"></i>
                    <span>Sales & Redemptions</span>
                </a>
            </li>
			<li class="active">
			<div class="pointer">
                    <div class="arrow"></div>
                    <div class="arrow_border"></div>
                </div>
                <a href="SocialShare.php">
				
                    <i class="icon-picture"></i>
                    <span>Social Settings</span>
                </a>
            </li>
			<li>
                <a href="AddNewPackage.php">
                    <i class="icon-calendar-empty"></i>
                    <span>Product Settings</span>
                </a>
            </li>
			<li>
                <a href="SpinSetting.php">
                    <i class="icon-th-large"></i>
                    <span>SpinWheel Settings</span>
                </a>
            </li>
            <li>
                <a href="UserList.php">
                    <i class="icon-group"></i>
                    <span>Users</span>
                    
                </a>
                
            </li>
            <li>
                <a href="NotificationCenter.php">
                    <i class="icon-group"></i>
                    <span>Notification Center</span>
                    
                </a>
                
            </li>
        </ul>
    </div>
    <!-- end sidebar -->


	<!-- main container -->
    <div class="content">

        <div class="container-fluid">

            <!-- upper main stats -->
            <div id="main-stats">
                <div class="row-fluid stats-row">
                    <div class="span2 stat">
                        <div class="data">
                            <span class="number"><?php echo getTotalNoOfUsers(); ?></span>
                            App Users
                        </div>
                        <span class="date">since <?php echo date('m-d-Y'); ?></span>
                    </div>
                    <div class="span2 stat">
                        <div class="data">
                            <span class="number"><?php echo getTotalNoOfUsers(); ?></span>
                            App Visits
                        </div>
                        <span class="date">since <?php echo date('m-d-Y'); ?></span>
                    </div>
                    <div class="span2 stat">
                        <div class="data">
                            <span class="number"><?php echo getTotalShareDetails(); ?></span>
                            Social shares
                        </div>
                        <span class="date">since <?php echo date('m-d-Y'); ?></span>
                    </div>
					<div class="span2 stat">
                        <div class="data">
                            <span class="number"><?php echo getTotalPointsEarned(); ?></span>
                            Points Earned
                        </div>
                        <span class="date">since <?php echo date('m-d-Y'); ?></span>
                    </div>
					<div class="span2 stat">
                        <div class="data">
                            <span class="number"><?php echo getTotalRedeemed(); ?></span>
                            Points Redeemed
                        </div>
                        <span class="date">since <?php echo date('m-d-Y'); ?></span>
                    </div>
                    <div class="span2 stat last">
                        <div class="data">
                            <span class="number"><?php echo getTotalOrderedPackage(); ?></span>
                            Products Ordered
                        </div>
                        <span class="date">since <?php echo date('m-d-Y'); ?></span>
                    </div>
                </div>
            </div>
            <!-- end upper main stats -->

            <div id="pad-wrapper">
			<h4 style="margin-bottom:10px;">Simply edit the point value you wish to reward for each social media share by clicking edit below. </h4>
                    <div class="row-fluid">
                        <table class="table">
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

echo '<tr style="background-color:#666666; color:#ffffff;"><td width=25% style="padding-left:10px; color:#ffffff;"><img src="image/fb_icon.png" /> &nbsp;&nbsp;'.$column1.' Points</td><td width=25% align="right" style=" color:#ffffff;"><img src="image/tw_icon.png" /> &nbsp;&nbsp;'.$column2.' Points</td><td width=25% style=" color:#ffffff;"><img src="image/ista_icon.png" /> &nbsp;&nbsp;'.$column3.' Points</td><td width=25% style=" color:#ffffff;"><img src="image/square_icon.png" /> &nbsp;&nbsp;'.$column4.' Points</td><td><input type="button" value="Edit" id="UpdateBtn" class="btn-glow" onclick="UpdateButtonClicked();" /></td></tr>';

}

?>
                            </tbody>
                        </table>
                    </div>
                    
               
                <!-- end table sample -->
				<h4 style="margin-bottom:10px;">Upload your content and graphic below. This is what your app users will see on their mobile devices and what can be shared on Facebook & Twitter. </h4>
               <div class="span6" id="UpdateDiv">
			   <form enctype="multipart/form-data" action="UpdateSocialPoints.php" method="post" onsubmit="return validate()">
				<table width=700px>
				<tr><td width=20%> Facebook Points</td><td width=55%><input type="text" id='Point1' name="Point1"/></td></tr>
				<tr><td width=30%> Twitter Points</td><td width=55%><input type="text" id='Point2' name="Point2"/></td></tr>
				<tr><td width=30%> Instagram Points</td><td width=55%><input type="text" id='Point3' name="Point3"/></td></tr>
				<tr><td width=30%> Foursquare Points</td><td width=55%><input type="text" id='Point4' name="Point4"/></td></tr>
				</table>
				<input type="submit" value="Submit" class="btn-flat inverse"/><span>&nbsp;&nbsp;<input type="button" class="btn-flat inverse" value="CANCEL" onclick="CancelButtonClicked();"/></span>
				</form>
				</div>
				
				
				
<div class="mainContainer"><!-- Start Main container sample -->
<div style=" overflow:hidden; overflow-x: hidden;" class="rightSocialDiv">  <!--Add new Package container -->
 <h4>Add New Social Content to your App </h4>
 <hr />
<form enctype="multipart/form-data" action="SocialShareDB.php" method="post" onsubmit="return socialvalidate()">
<span>Please select the category from dropdown:&nbsp;&nbsp;&nbsp;&nbsp;</span><select id="orderdropdown" name="orderdropdown" onchange="socialShareDropDown();">
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
<a href="#" class="topopup" style="display:none;">Preview</a>
<br /><br />
</div><!--End of Add new package container -->
<!--
<div class="previewDiv"> <!-- Preview div 
<br /><br />
<img src="image/avatar.jpg" id="prevImage" class="background-image" />
<p class="overlay-text" id="preTitle">Title</p>
<p class="overlay-text" id="preDesc">Description</p>
</div>--> <!--End of preview div -->

</div><!-- end Main container sample -->

</div>
	
                <!-- table sample -->
                <!-- the script for the toggle all checkboxes from header is located in js/theme.js -->
				
                    <div class="row-fluid">
                        <table class="table table-hover">
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

echo '<tr style="background-color:'.$colorCode.'"><td width=5% style="padding-left:10px;">'.$index.'</td><td width=15% align="right">'.$tableName[1].'&nbsp;&nbsp;</td><td width=30%>'.$tableName[2].'</td><td width=10%><a href="'.$tableName[5].'" target="_blank" >Social Link</a></td><td width=10%>'.date("m-d-Y", strtotime($tableName[4])).'</td><td width=5%><input type="button" value="Edit" class="btn-flat inverse"  onclick="EditClicked(\''.$tableName[0].'\',\''.$tableName[15].'\')"></td><td width=5%><input type="button" value="Delete" class="btn-flat danger"  onclick="DeleteClicked(\''.$tableName[0].'\')"></td></tr>';

++$index;
}

?>
                            </tbody>
                        </table>
                    </div>
                <!-- end table sample -->

            </div>
        </div>
    </div>

<!--Start of topopup box -->
<div id="toPopup">

        <div class="close"></div>
       	<span class="ecs_tooltip">Press Esc to close <span class="arrow"></span></span>
		<div id="popup_content"> <!--your content start-->
		<br /><br />
		<br /><br />
		<br /><br />
		<br /><br />
		<br /><br />
		<br /><br />
            <h3 align="center">Social Post Preview Box </h3>
            <br /><br />
            <br /><br />
            <br /><br />
            <br /><br />
            <br /><br />
			<br /><br />
        </div> <!--your content end-->

</div> <!--toPopup end-->

<div class="loader"></div>
<div id="backgroundPopup"></div>

<!-- scripts -->
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery-ui-1.10.2.custom.min.js"></script>
    <!-- knob -->
    <script src="js/jquery.knob.js"></script>
    <!-- flot charts -->
    <script src="js/jquery.flot.js"></script>
    <script src="js/jquery.flot.stack.js"></script>
    <script src="js/jquery.flot.resize.js"></script>
    <script src="js/theme.js"></script>
    
    <script type="text/javascript">
	
	function EditClicked(pkgId,category){
			//alert(pkgId);
			window.location.href='SocialShareEdit.php?socialid='+pkgId+'&category='+category;
	}
	function DeleteClicked(pkgId){
			//alert(pkgId+"delete");
			window.location.href='SocialShareDelete.php?id='+pkgId;
	}
	function socialTitleChange(){
		document.getElementById("preTitle").innerHTML=document.getElementById("title").value;
	}
	function socialDescChange(){
		document.getElementById("preDesc").innerHTML=document.getElementById("desc").value;
	}
	
	function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#prevImage').attr('src', e.target.result);
			$('#prevImage').style.width = "300px";
			$('#prevImage').style.height = "200px";
        }
        reader.readAsDataURL(input.files[0]);
    }
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
	
	function validate(){
	
	if(document.getElementById('Point1').value.length && document.getElementById('Point2').value.length && document.getElementById('Point3').value.length && document.getElementById('Point4').value.length )
	{
		return true;
	}
	else{
	alert("Please fill the form completely.");
	return false;
	}
	}
	
	function socialvalidate(){
	
	if(document.getElementById('title').value.length && document.getElementById('desc').value.length && document.getElementById('file').value.length && document.getElementById('link').value.length )
	{
		return true;
	}
	else{
	alert("Please fill the form completely.");
	return true;
	}
	}
	
	function socialShareDropDown(){
	
		var selectedVal=document.getElementById("orderdropdown").value;
		if(selectedVal=="Coupon"){
			var addPicker='<h4>Coupon Block</h4><hr /> ';
			var tableContent=addPicker+' <input type="hidden" name="category" value="coupon"><table width=100%><tr><td width=20%>Choose Logo:</td><td width=80%><input type="file" name="logofile" id="logofile" ></td></tr><tr><td ></td><td style="font-weight:bold">Please upload image size of 200 X 200 pixels</td></tr><tr><td width=20%>Choose Image:</td><td width=80%><input type="file" name="file" id="file" onchange="readURL(this);"><span id="imgError" style="color:red;"><?php echo $errorMsg; ?></span></td></tr><tr><td ></td><td style="font-weight:bold">Please upload image size of 640 X 440 pixels</td></tr><tr><td width=20%>Coupon Title:</td><td width=80%><input type="text" name="title" id="title" onChange="socialTitleChange();" placeholder="Title"></td></tr><tr><td width=20%>Description:</td><td width=80%><textarea name="desc" id="desc" rows=7 cols=80 onChange="socialDescChange();" placeholder="Description" ></textarea></td></tr><tr colspan=2><td width=20%>% Savings:</td><td width=80%><input type="text" id="savingper" name="savingper"></td></tr><tr colspan=2><td width=20%>Enter Point Value:</td><td width=80%><input type="text" id="pointval" name="pointval"></td></tr><tr><td ></td><td style="font-weight:bold">This point will be rewared when user will share the coupon.</td></tr><tr colspan=2><td width=20%>Enter Coupon Amount:</td><td width=80%><input type="text" id="amountval" name="amountval"></td></tr><tr colspan=2><td width=20%>Tags:</td><td width=80%><input type="text" id="tags" name="tags"></td></tr><tr colspan=2><td width=20%>Color:</td><td width=80%><input class="color" name="colorcode" value="c11629"></td></tr><tr colspan=2><td width=20%>Send Notification:</td><td width=80%><input type="checkbox" id="noticheckbox" name="noticheckbox"></td></tr>';	
			var expiredays='<tr><td width="20%">Valid till:</td><td width="80%"><select name="expiredays"><option value="1">&nbsp;&nbsp;1 day</option><option value="7">&nbsp;&nbsp;1 week</option><option value="30">&nbsp;&nbsp;1 month</option></select></td></tr></table><br /><input type="submit" value="Submit" class="btn-flat inverse"> ';
			document.getElementById("contentDiv").innerHTML=tableContent+" "+expiredays;
			jscolor.init();
		}
		else if(selectedVal=="Picture"){
			document.getElementById("contentDiv").innerHTML='<input type="hidden" name="category" value="picture"><h4>Picture Block</h4><hr /><table width=100%><tr><td width=20%>Upload Image:</td><td width=80%><input type="file" name="file" id="file" onchange="readURL(this);"><span id="imgError" style="color:red;"><?php echo $errorMsg; ?></span></td></tr><tr><td ></td><td style="font-weight:bold">Please upload image size of 640 X 440px</td></tr><tr><td width=20%>Title:</td><td width=80%><input type="text" name="title" id="title" onChange="socialTitleChange();" placeholder="Title"></td></tr><tr><td width=20%>Description:</td><td width=80%><textarea name="desc" id="desc" rows=7 cols=80 onChange="socialDescChange();" placeholder="Description" ></textarea></td></tr><tr colspan=2><td width=20%>Enter Point Value:</td><td width=80%><input type="text" id="pointval" name="pointval"></td></tr><tr colspan=2><td width=20%>Tags:</td><td width=80%><input type="text" id="tags" name="tags"></td></tr><tr colspan=2><td width=20%>URL:</td><td width=80%><input type="text" id="link" name="link"></td></tr><tr colspan=2><td width=20%>Send Notification:</td><td width=80%><input type="checkbox" id="noticheckbox" name="noticheckbox"></td></tr></table><br /><input type="submit" value="Submit" class="btn-flat inverse"><!-- End of Picture Block div -->';
		}
		else if(selectedVal=="Blog"){
			document.getElementById("contentDiv").innerHTML='<input type="hidden" name="category" value="blog"><h4>Blog Block</h4><hr /><table width=100%><tr><td width=20%>Upload Image:</td><td width=80%><input type="file" name="file" id="file" onchange="readURL(this);"><span id="imgError" style="color:red;"><?php echo $errorMsg; ?></span></td></tr><tr><td ></td><td style="font-weight:bold">Please upload image size of 640 X 440px</td></tr><tr><td width=20%>Blog Title:</td><td width=80%><input type="text" name="title" id="title" onChange="socialTitleChange();" placeholder="Title"></td></tr><tr><td width=20%>Description:</td><td width=80%><textarea name="desc" id="desc" rows=7 cols=80 onChange="socialDescChange();" placeholder="Description" ></textarea></td></tr><tr colspan=2><td width=20%>Enter Point Value:</td><td width=80%><input type="text" id="pointval" name="pointval"></td></tr><tr colspan=2><td width=20%>Writer name:</td><td width=80%><input type="text" id="writername" name="writername"></td></tr><tr colspan=2><td width=20%>Tags:</td><td width=80%><input type="text" id="tags" name="tags"></td></tr><tr colspan=2><td width=20%>URL:</td><td width=80%><input type="text" id="link" name="link"></td></tr><tr colspan=2><td width=20%>Send Notification:</td><td width=80%><input type="checkbox" id="noticheckbox" name="noticheckbox"></td></tr></table><br /><input type="submit" value="Submit" class="btn-flat inverse"><!-- End of Blog Block div -->';
		}
		else if(selectedVal=="Text"){
			document.getElementById("contentDiv").innerHTML='<input type="hidden" name="category" value="text">';
		}
		else if(selectedVal=="Video"){
			document.getElementById("contentDiv").innerHTML='<input type="hidden" name="category" value="video"><h4>Video Block</h4><hr /><table width=100%><tr><td width=20%>Video Title:</td><td width=80%><input type="text" name="title" id="title" onChange="socialTitleChange();" placeholder="Title"></td></tr><tr><td width=20%>Video Link:</td><td width=80%><input type="text" name="link" id="link" onChange="socialTitleChange();" placeholder="Video URL"></td></tr><tr colspan=2><td width=20%>Enter Point Value:</td><td width=80%><input type="text" id="pointval" name="pointval"></td></tr><tr colspan=2><td width=20%>Tags:</td><td width=80%><input type="text" id="tags" name="tags"></td></tr><tr colspan=2><td width=20%>Send Notification:</td><td width=80%><input type="checkbox" id="noticheckbox" name="noticheckbox"></td></tr></table><br /><input type="submit" value="Submit" class="btn-flat inverse"><!-- End of Blog Block div -->';
		}
		else if(selectedVal=="Podcast"){
			document.getElementById("contentDiv").innerHTML='<input type="hidden" name="category" value="podcast"><h4>Podcast Block</h4><hr /><table width=100%><tr><td width=20%>Podcast Title:</td><td width=80%><input type="text" name="title" id="title" onChange="socialTitleChange();" placeholder="Title"></td></tr><tr><td width=20%>Podcast Link:</td><td width=80%><input type="text" name="link" id="link" onChange="socialTitleChange();" placeholder="Podcast URL"></td></tr><tr colspan=2><td width=20%>Enter Point Value:</td><td width=80%><input type="text" id="pointval" name="pointval"></td></tr><tr colspan=2><td width=20%>Tags:</td><td width=80%><input type="text" id="tags" name="tags"></td></tr><tr colspan=2><td width=20%>Send Notification:</td><td width=80%><input type="checkbox" id="noticheckbox" name="noticheckbox"></td></tr></table><br /><input type="submit" value="Submit" class="btn-flat inverse"><!-- End of Blog Block div -->';
		}
		else if(selectedVal=="select"){
			document.getElementById("contentDiv").innerHTML='<input type="hidden" name="category" value="select">';
		}
	}
	
	loadDefaultValue(); 
    </script>
    
    
</body>
</html>