<?php
session_start();
include_once 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="SocialShareDetails"; // Table name

if(!isset($_SESSION['myusername'])){
header("Location: ../admin/index.html");
}
// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$sql="SELECT * FROM $tbl_name where Id='".$_GET['id']."'";
$result=mysql_query($sql);
$tableName = mysql_fetch_row($result);
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
	<link href="css/additionalStyle.css" rel="stylesheet" type="text/css"> 
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
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
                <a href="SocialSetting.php">
                    <i class="icon-picture"></i>
                    <span>Social Settings</span>
                </a>
            </li>
			<li >
                
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
            
        </ul>
    </div>
    <!-- end sidebar -->


	<!-- main container -->
    <div class="content">

        <!-- settings changer 
        <div class="skins-nav">
            <a href="#" class="skin first_nav selected">
                <span class="icon"></span><span class="text">Default skin</span>
            </a>
            <a href="#" class="skin second_nav" data-file="css/skins/dark.css">
                <span class="icon"></span><span class="text">Dark skin</span>
            </a>
        </div>-->

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
                <h4>Edit Social Share Details </h4>
				
                    <div class="row-fluid">
                      
<div style=" overflow:hidden; overflow-x: hidden;" class="span11">  <!--Add new Package container -->
 
 <hr />
<form enctype="multipart/form-data" action="SocialEditPackageDB.php" method="post" onsubmit="return validate()">
<input type="hidden" value="<?php echo $_GET['id']; ?>" name="id" />
<table width=900px>
<tr>
<td width=20%>Title</td><td width=80%><input type="text" name="title" id="title" value="<?php echo $tableName[1]; ?>"></td>
</tr>
<tr>
<td width=20%>Description</td><td width=80%><textarea name="desc" id="desc" rows=7 cols=80 ><?php echo $tableName[2]; ?></textarea></td>
</tr>
<tr>
<td width=20%>Upload Image</td><td width=80%><input type="file" name="file" id="file"><span id="imgError" style="color:red;"><?php echo $errorMsg; ?></span></td>
</tr>
<tr>
<td width=20%>Hyperlink</td><td width=80%><input type="text" id="link" name="link" value="<?php echo $tableName[5]; ?>"></td>
</tr>
</table>
<input type="submit">

</form>
</div><!--End of Add new package container -->
                    </div>
                   
                </div>
                <!-- end table sample -->
            </div>
       <!-- </div>  -->
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
			alert(pkgId);
		}

    </script>
</body>
</html>