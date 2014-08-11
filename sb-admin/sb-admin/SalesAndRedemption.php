<?php
session_start();
include_once 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="MonthlyPackageUsers"; // Table name

if(!isset($_SESSION['myusername'])){
header("Location: index.php");
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
			<li class="active" >
			<div class="pointer">
                    <div class="arrow"></div>
                    <div class="arrow_border"></div>
                </div>
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
                <a  href="UserList.php">
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
               <!-- <h4>Monthly Package Details </h4>
				
                    <div class="row-fluid">
                        <table class="table table-hover" width=320px>
                            <thead>
                                <tr>
                                    <th class="span3" colspan="1">
                                        Index
                                    </th>
                                    <th class="span3" colspan="1">
                                        <span class="line"></span>User Name
                                    </th>
                                    <th class="span3" colspan="1">
                                        <span class="line"></span>Title
                                    </th>
									 <th class="span3" colspan="1">
                                        <span class="line"></span>Description
                                    </th>
									<th class="span3" colspan="1">
                                        <span class="line"></span>Points
                                    </th>
									<th class="span3" colspan="1">
                                        <span class="line"></span>Amount
                                    </th>
									<th class="span3" colspan="1">
                                        <span class="line"></span>Added Date
                                    </th>
                                    <th class="span3" colspan="1">
                                        <span class="line"></span>PIN
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

echo '<tr style="background-color:'.$colorCode.'"><td width=5% style="padding-left:10px;">'.$index.'</td><td width=10% align="right">'.$tableName[1].' '.$tableName[2].'&nbsp;&nbsp;</td><td width=20%>'.$tableName[3].'</td><td width=30%>'.$tableName[4].'</td><td width=10%>'.$tableName[8].' Points</td><td width=10%>$'.$tableName[7].'</td><td width=20%>'.date("m-d-Y", strtotime($tableName[5])).'</td><td width=10%>'.$tableName[10].'</td></tr>';

++$index; 
}

?>
                            </tbody>
                        </table>
                    </div> -->
                <!-- end table sample -->

<!--Redemed table details -->

                <h4>Redemed Points Details </h4>
				
                    <div class="row-fluid">
                        <table class="table table-hover">
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
                <!-- end table sample -->

<!--End of redemed table -->				
                    <div class="row-fluid">
                      

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
			//alert(pkgId);
			window.location.href='EditPackage.php?id='+pkgId;
		}

    </script>
</body>
</html>