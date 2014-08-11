<?php
function str_replace_once($str_pattern, $str_replacement, $string){

    if (strpos($string, $str_pattern) !== false){
        $occurrence = strpos($string, $str_pattern);
        return substr_replace($string, $str_replacement, strpos($string, $str_pattern), strlen($str_pattern));
    }

    return $string;
}

session_start();
include_once 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="PackageDetails"; // Table name

if(!isset($_SESSION['myusername'])){
header("Location: ../admin/index.html");
}
// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$sql="SELECT * FROM $tbl_name where isActive='1' ORDER BY AddedDate DESC";
$result=mysql_query($sql);
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
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    
    <link href="css/additionalStyle.css" rel="stylesheet" type="text/css">
</head>
<body >

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
			<li>
                <a href="SocialShare.php">
                    <i class="icon-picture"></i>
                    <span>Social Settings</span>
                </a>
            </li>
			<li class="active">
                <div class="pointer">
                    <div class="arrow"></div>
                    <div class="arrow_border"></div>
                </div>
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
                                <!-- table sample -->
                <!-- the script for the toggle all checkboxes from header is located in js/theme.js -->
                <h4 style="margin-bottom:10px;">Product and Package Settings </h4>
				
                    <div class="row-fluid">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th class="span3" colspan="1">
                                        INDEX
                                    </th>
                                    <th class="span6" colspan="1">
                                        <span class="line"></span>TITLE
                                    </th>
                                    <th class="span3" colspan="1">
                                        <span class="line"></span>PACKAGE DESCRIPTION
                                    </th>
									 <th class="span6" colspan="1">
                                        <span class="line"></span>POINT VALUE
                                    </th>
									<th class="span6" colspan="1">
                                        <span class="line"></span>$ Amount
                                    </th>
									<th class="span6" colspan="1">
                                        <span class="line"></span>DATE ADDED
                                    </th>
                                    <th class="span6" colspan="2">
                                        <span class="line"></span>Edit
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

echo '<tr style=" vertical-align:top; background-color:'.$colorCode.'"><td width=5% style="padding-left:10px; vertical-align:top; " valign="top">'.$index.'</td>
<td width=20% style="vertical-align:top;" align="right" valign="top">'.str_replace_once("$^^^$", " ", $tableName[1]).'&nbsp;&nbsp;</td>
<td width=35% style="vertical-align:top;">'.$tableName[2].'</td><td width=14% style="vertical-align:top;">'.$tableName[4].' Points</td>
<td width=11% style="vertical-align:top;">$'.$tableName[5].'</td><td width=10% style="vertical-align:top;">'.date("m-d-Y", strtotime($tableName[6])).'</td>
<td width=5% style="vertical-align:top;"><input type="button" class="btn-flat inverse" value="Edit"  onclick="EditClicked(\''.$tableName[0].'\')"></td>
<td width=5% style="vertical-align:top;"><input type="button" value="Delete" class="btn-flat danger"  onclick="DeleteClicked(\''.$tableName[0].'\')"></td></tr>';

++$index; 
}

?>
                            </tbody>
                        </table>
                    </div>
                <!-- end table sample -->
				
                    <div class="row-fluid">
					
<div class="mainContainer"><!-- Start Main container sample -->               
<div style=" height: auto; overflow:hidden; overflow-x: hidden;" class="rightSocialDiv">  

<!--Add new Package container -->

<form action="AddNewPackageDB.php" method="post" enctype="multipart/form-data" onsubmit="return validatePackage()">
<table width=900px>

<tr>
<td width=20%>Title</td><td width=80%><input type="text" name="title" id="title" onChange="socialTitleChange();" placeholder="Title of the package"></td>
</tr>
<tr>
<td width=20%>Description</td><td width=80% style="vertical-align:top;"><textarea name="desc" id="desc" rows=7 cols=80 onChange="socialDescChange();" placeholder="Description of your product, package or service"></textarea><span style="vertical-align:bottom; color:#666666;">&nbsp;&nbsp;250 characters</span></td>
</tr>
<tr>
<td width=20%>Upload Image</td><td width=80%><input type="file" name="file" id="file" onchange="readURL(this);"> <span id="imgError" style="color:red;"><?php echo $errorMsg; ?></span> </td>
</tr>
<tr>
<td ></td><td style="font-weight:bold">Please upload image size of 640 X 440px</td>
</tr>
<tr>
<td width=20%>Points</td><td width=80%><input type="text" name="points" id="points" onchange="pointTextChanged();" placeholder="Points require to redeem this package."></td>
</tr>
<tr>
<td width=20%>Amount</td><td width=80%><input type="text" name="amount" id="amount" onchange="amountTextChanged();" placeholder="$ The dollar value of this package"></td>
</tr>
<tr>
<td width=20%>IsActive</td><td width=80%><select name="isactive"><option value="1">YES</option><option value="0">NO</option></td>
</tr>
<tr>
<td width=20%>Type</td><td width=80%><select name="type" onChange="typeDropDownChange();" id="typeDropDown"><option value="P">Package</option><option value="V">Voucher</option><option value="B">Bed</option></td>
</tr>
<tr id="levelCell">
<td width=20%>Level</td><td width=80%><input type="text" name="level" id="level"  placeholder="Bed Level"></td>
</tr>
<tr>
<td width=20%>Package Duration</td><td width=80%><select name="pkgDuration"><option value="N">Instant</option></td>
</tr>
</table>
<input class="btn-flat inverse" type="submit" value="Submit">
<!--End of Add new package container -->
</form>
</div>
<!-- Preview div -->
<div class="previewDiv" style="display:none;"> 
<br /><br />
<img src="image/avatar.jpg" id="prevImage" class="background-image" />
<p class="overlay-text" id="preTitle">Title</p>
<p class="overlay-text" id="preDesc">Description</p>
</div> <!--End of preview div -->
</div><!-- end Main container sample -->

                    </div>
                   
                </div>
                <!-- end table sample -->
            </div>
    </div>


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
        function EditClicked(pkgId){
			//alert(pkgId);
			window.location.href='EditPackage.php?id='+pkgId;
		}
		function DeleteClicked(pkgId){
			//alert(pkgId+"delete");
			window.location.href='PackageDeleteDB.php?id='+pkgId;
		}
		function socialTitleChange(){
		document.getElementById("preTitle").innerHTML=document.getElementById("title").value;
	}
	function socialDescChange(){
		document.getElementById("preDesc").innerHTML=document.getElementById("desc").value;
	}
	
	function pointTextChanged(){
		
		var pointText=document.getElementById('points');
		var amountText=document.getElementById('amount');
		
		if(!isNaN(pointText.value)){
		
			var amountConvertVal=pointText.value*5;
			amountConvertVal=amountConvertVal/100.0;
			amountText.value=amountConvertVal;
		}
		else{
			alert("Point should be numeric.");
		}
		
	}
	
	function amountTextChanged(){
		
		var amountText=document.getElementById('amount');
		var pointText=document.getElementById('points');
		
		if(!isNaN(amountText.value)){
			var pointConvertVal=amountText.value*100.0;
			pointConvertVal=pointConvertVal/5.0;
			pointText.value=pointConvertVal;
		}
		else{
			alert("Amount should be numeric.");
		}
	}
	
	function typeDropDownChange()
	{
		if(document.getElementById("typeDropDown").value=="B")
		{
			document.getElementById("levelCell").style.display = "";
		}
		else{
			document.getElementById("levelCell").style.display = "none";
		}
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
		function validatePackage(){
			var file = $('#file')[0].files[0];
			var filename=file.name;
			var fileExtension = file.name.substring(file.name.lastIndexOf('.') + 1); 
			var filesize=file.size;
			
			var status=true;
			
			if(document.getElementById("title").value.length<=0){
				alert("Please enter the package title.");
				return false;
			}
			if(document.getElementById("desc").value.length<=0 || document.getElementById("desc").value.length>500 ){
				alert("Please enter the package description less than 500 characters.");
				return false;
			}
			
			// File image validation
			
			if(filename.indexOf(' ') !== -1)
			{
  				alert("Image name should not contain spaces.");
  				return false;
			}
			
			if(!(fileExtension=="jpeg" || fileExtension=="jpg" || fileExtension=="png") )
			{
  				alert("Image extension should be either .png, .jpg, .jpeg .");
  				return false;
			}
			
			if(filesize>1024*1024*2)
			{
  				alert("Image size should be less than 2MB.");
  				return false;
			}
			
			// End of file image validation
			
			if(document.getElementById("points").value.length<=0 || isNaN(document.getElementById("points").value)){
				alert("Please enter the package points.");
				return false;
			}
			if(document.getElementById("amount").value.length<=0 || isNaN(document.getElementById("amount").value)){
				alert("Please enter the package amount.");
				return false;
			}
			return true;
		}
		
		function onHTMLLoad(){
			document.getElementById("levelCell").style.display = "none";
		}
		onHTMLLoad();
    </script>
</body>
</html>