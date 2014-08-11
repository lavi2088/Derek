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

$sql="SELECT * FROM $tbl_name ";
$result=mysql_query($sql);
?>
	<!DOCTYPE html>
	<html lang="en">
	  <head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">

		<title><?php echo $appname; ?> - User List</title>

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
				<h1><?php echo $appname; ?> <small>User List</small></h1>
				<ol class="breadcrumb">
				  <li><a href="w_dashboardhome.php"><i class="fa fa-dashboard"></i> Dashboard</a></li>
				  <li class="active"><i class="fa fa-edit"></i> Users</li>
				</ol>
				
			  </div>
			</div><!-- /.row -->
			
			
			
			<h4 >Registered User List: </h4>
			
			<br />

				
						
						
			<div class="row">
			  <div class="col-lg-12">
				<h2>Users</h2>
				<div class="table-responsive">
					<table class="table table-hover tablesorter">
							   <thead>
                                <tr>
                                <th class="span3" colspan="1">
                                        Status
                                    </th>
                                    <th class="span3" colspan="1">
                                        User Name
                                    </th>
                                    <th class="span3" colspan="1">
                                        <span class="line"></span>Member Since
                                    </th>
                                    <th class="span3" colspan="1">
                                        <span class="line"></span>Total Point Redeemed
                                    </th>
									 <th class="span3" colspan="1">
                                        <span class="line"></span>Current Point Balance
                                    </th>
									<th class="span2" colspan="1">
                                        <span class="line"></span>History
                                    </th>
                                    <th class="span2" colspan="2">
                                        <span class="line"></span>Activity
                                    </th>
                                     <th class="span2" colspan="1">
                                        <span class="line"></span>Bonus
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
								
<?php
$counter=0;
$colorCode="";
while($tableName = mysql_fetch_row($result)) {

if($counter%2==0){
$colorCode="#f7f7f7";
}
else{
$colorCode="#ffffff";
}

$iconStatus="";
if($tableName[17]==0){
	$iconStatus="image/AbsentRed.png";
}
else{
	$iconStatus="image/ApproveGreen.png";
}

$counter++;
$shareDesc="";
$shareImgName="";


echo '<tr style="background-color:'.$colorCode.'"><td><img src="'.$iconStatus.'"></td><td width=30% style="padding-left:10px;">'.$tableName[11].' '.$tableName[12].'</td>
<td width=20%>'.date("m-d-Y", strtotime($tableName[13])).'</td><td width=20% >'.getTotalRedeemedData($tableName[0]).'&nbsp;&nbsp;</td><td width=20%>'.getTotalAccountPointsData($tableName[0]).'</td>
<td width=10%><a href="UserHistory.php?userid='.$tableName[0].'" >History</a></td><td width=5%><a href="BlockUser.php?userid='.$tableName[0].'&val=0" >Block</a></td>
<td width=5%><a href="BlockUser.php?userid='.$tableName[0].'&val=1" >Unblock</a></td><td width=5%><a href="Bonus.php?userid='.$tableName[0].'&val=1" >Bonus</a></td></tr>';

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
		
		
		</script>
	</html>