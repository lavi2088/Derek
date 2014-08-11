<?php
session_start();
include_once 'dbconfig.php';
include 'GlobalFunction.php';
include 'w_dashboardConfig.php';
$tbl_name="activitylog"; // Table name

if(!isset($_SESSION['myusername'])){
header("Location: index.php");
}
// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$sql="SELECT * FROM $tbl_name where user_name='".$_GET['userid']."'";
$result=mysql_query($sql);
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title><?php echo $appname; ?> - User History</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">

    <!-- Add custom CSS here -->
    <link href="css/sb-admin.css" rel="stylesheet">
    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
	<link href="css/additionalStyle.css" rel="stylesheet" type="text/css">
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
            <li><a href="w_socialshare.php"><i class="fa fa-bar-chart-o"></i> Social Share</a></li>
            <li><a href="SpinSetting.php"><i class="fa fa-table"></i> Spin Wheel</a></li>
            <li class="active"><a href="NotificationCenter.php"><i class="fa fa-edit"></i> Notifications</a></li>
            <li ><a href="#"><i class="fa fa-edit"></i> Package Details</a></li>
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
            <h1><?php echo $appname; ?> <small>User History</small></h1>
            <ol class="breadcrumb">
              <li><a href="w_dashboardhome.php"><i class="fa fa-dashboard"></i> Dashboard</a></li>
              <li class="active"><i class="fa fa-edit"></i> User History</li>
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

		<h3> User History </h3>
		
		<div class="table-responsive">
			<div class="col-lg-12">
				<table class="table table-hover tablesorter">
                             <thead>
                                <tr>
                                    <th class="span3" colspan="1">
                                        Activity Title
                                    </th>
                                    <th class="span3" colspan="1">
                                        <span class="line"></span>Activity Type
                                    </th>
                                    <th class="span3" colspan="1">
                                        <span class="line"></span>Activity Date
                                    </th>
									 <th class="span3" colspan="1">
                                        <span class="line"></span>Status
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
$counter++;
$status="";
$shareName="";
if($tableName[3]=='R')
{
$shareName="Redeemed";
}
else{
$shareName="Social";
}

if($tableName[9]=='A')
{
$status="Approved";
}
else{
$status="Pending";
}

echo '<tr style="background-color:'.$colorCode.'"><td width=30% style="padding-left:10px;">'.$tableName[4].'</td><td width=20%>'.$shareName.'</td><td width=20% align="right">'.date("m-d-Y", strtotime($tableName[5])).'&nbsp;&nbsp;</td><td width=20%>'.$status.'</td></tr>';

}

?>
                            </tbody>
                        </table>
			</div>
		</div>

      </div><!-- /#page-wrapper -->

    </div><!-- /#wrapper -->

    <!-- JavaScript -->
    <script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.js"></script>

    <!-- Page Specific Plugins -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
    <script src="http://cdn.oesmith.co.uk/morris-0.4.3.min.js"></script>
    <script src="js/morris/chart-data-morris.js"></script>
    <script src="js/tablesorter/jquery.tablesorter.js"></script>
    <script src="js/tablesorter/tables.js"></script>
    <!--[if lte IE 8]><script src="js/excanvas.min.js"></script><![endif]-->
	<script src="js/flot/jquery.flot.js"></script>
	<script src="js/flot/jquery.flot.tooltip.min.js"></script>
	<script src="js/flot/jquery.flot.resize.js"></script>
	<script src="js/flot/jquery.flot.pie.js"></script>
	<script src="js/flot/chart-data-flot.js"></script>

  </body>
    
	<script type="text/javascript">
	
	//Flot Line Chart with Tooltips
	$(document).ready(function(){
	console.log("document ready");
	var offset = 0;
	plot();
	function plot(){
		
		var facebook = <?php echo getFacebookGraphData(); ?>//[[1, 50], [2, 40], [3, 45], [4, 23],[5, 55],[6, 65],[7, 61],[8, 70],[9, 65],[10, 75],[11, 57],[12, 59]];
            var twitter =<?php echo getTwitterGraphData(); ?>// [[1, 25], [2, 50], [3, 23], [4, 48],[5, 38],[6, 40],[7, 47],[8, 55],[9, 43],[10,50],[11,47],[12, 39]];
			var istagram = <?php echo getInstagramGraphData(); ?> //[[1, 50], [2, 40], [3, 15], [4, 63],[5, 35],[6, 65],[7, 31],[8, 70],[9, 55],[10, 35],[11, 57],[12, 59]];
            var frsquare = <?php echo getFoursquareGraphData(); ?> //[[1, 25], [2, 0], [3, 67], [4, 28],[5, 38],[6, 40],[7, 17],[8, 45],[9, 43],[10,0],[11,0],[12, 0]];
			
		var options = {
			series: {
				lines: { show: true },
				points: { show: true }
			},
			grid: { hoverable: true, 
                           clickable: true, 
                           tickColor: "#f9f9f9",
                           borderWidth: 0
                        },
			legend: {
                         // show: false
                         labelBoxBorderColor: "#fff"
                    },  
            colors: ["#3b5998", "#55acee",'#000','#ff7900'],
			xaxis: {
                        ticks: [[1, "JAN"], [2, "FEB"], [3, "MAR"], [4,"APR"], [5,"MAY"], [6,"JUN"], 
                               [7,"JUL"], [8,"AUG"], [9,"SEP"], [10,"OCT"], [11,"NOV"], [12,"DEC"]],
                        font: {
                            size: 12,
                            family: "Open Sans, Arial",
                            variant: "small-caps",
                            color: "#697695"
                        }
                    },
			yaxis: {
                        ticks:3, 
                        tickDecimals: 0,
                        font: {size:12, color: "#9da3a9"}
                    },
			tooltip: true,
			tooltipOpts: {
				content: "%s number of shares are %y.4",
				shifts: {
					x: -20,
					y: 25
				}
			}
		};
	
		var plotObj = $.plot( $("#flot-chart-line"),
			[ { data: facebook, label: "Facebook"}, { data: twitter, label: "Twitter" }, { data: istagram, label: "Instagram" }, { data: frsquare, label: "Foursquare" } ],
			options );
	}
	});
	
	function approveClicked(id,type,postid){

//alert(type+" Approve"+id+" "+postid);
var point=0;

if(type=='F')
{
point=5;
}
else if(type=='T')
{
point=3;
}
else if(type=='I')
{
point=10;
}
else if(type=='FR')
{
point=2;
}
else if(type=='SP')
{
point=5;
}
//alert("afetr point"+point);
$.ajax({
        url: 'UpdateFile.php',
        type: 'POST',
        data: {userid:''+id,type:""+type,postid:''+postid, point:""+point},
        success: function(response){
          // alert(response);
         window.location.reload();
        },
        error: function(){
alert("Error")
            console.log(arguments);
        }
     });
}

function denyClicked(id,type,postid){

//alert(type+" Deny"+id);
$.ajax({
        url: 'updateDenyStatus.php',
        type: 'POST',
        data: {userid:''+id,type:""+type,postid:''+postid},
        success: function(response){
           //alert(response);
         window.location.reload();
        },
        error: function(){
            console.log(arguments);
        }
     });
}
	</script>
</html>