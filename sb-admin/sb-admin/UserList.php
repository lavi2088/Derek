<?php
session_start();
include_once 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="userdetail"; // Table name

if(!isset($_SESSION['myusername'])){
header("Location: ../admin/index.php");
}
// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$sql="SELECT * FROM $tbl_name ";
$result=mysql_query($sql);
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
            <li class="active">
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
            <li class="active">
			<div class="pointer">
                    <div class="arrow"></div>
                    <div class="arrow_border"></div>
                </div>
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
				<h3>User List</h3>
				<br />
                <!-- table sample -->
                <!-- the script for the toggle all checkboxes from header is located in js/theme.js -->
                    <div class="row-fluid">
                        <table class="table table-hover">
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
<td width=20%>'.date("m-d-Y", strtotime($tableName[13])).'</td><td width=20% align="right">'.getTotalRedeemedData($tableName[0]).'&nbsp;&nbsp;</td><td width=20%>'.getTotalAccountPointsData($tableName[0]).'</td>
<td width=10%><a href="UserHistory.php?userid='.$tableName[0].'" >History</a></td><td width=5%><a href="BlockUser.php?userid='.$tableName[0].'&val=0" >Block</a></td>
<td width=5%><a href="BlockUser.php?userid='.$tableName[0].'&val=1" >Unblock</a></td><td width=5%><a href="Bonus.php?userid='.$tableName[0].'&val=1" >Bonus</a></td></tr>';

}

?>
                            </tbody>
                        </table>
                    </div>
                    <div class="pagination">
                      <ul>
                        <li><a href="#">&#8249;</a></li>
                        <li><a class="active" href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">&#8250;</a></li>
                      </ul>
                    </div>
                <!-- end table sample -->
            </div>
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
        $(function () {

            // jQuery Knobs
            $(".knob").knob();
			
            // jQuery UI Sliders
            $(".slider-sample1").slider({
                value: 100,
                min: 1,
                max: 500
            });
            $(".slider-sample2").slider({
                range: "min",
                value: 130,
                min: 1,
                max: 500
            });
            $(".slider-sample3").slider({
                range: true,
                min: 0,
                max: 500,
                values: [ 40, 170 ],
            });

            // jQuery Flot Chart
			
            var facebook = <?php echo getFacebookGraphData(); ?>//[[1, 50], [2, 40], [3, 45], [4, 23],[5, 55],[6, 65],[7, 61],[8, 70],[9, 65],[10, 75],[11, 57],[12, 59]];
            var twitter =<?php echo getTwitterGraphData(); ?>// [[1, 25], [2, 50], [3, 23], [4, 48],[5, 38],[6, 40],[7, 47],[8, 55],[9, 43],[10,50],[11,47],[12, 39]];
			var istagram = <?php echo getInstagramGraphData(); ?> //[[1, 50], [2, 40], [3, 15], [4, 63],[5, 35],[6, 65],[7, 31],[8, 70],[9, 55],[10, 35],[11, 57],[12, 59]];
            var frsquare = <?php echo getFoursquareGraphData(); ?> //[[1, 25], [2, 0], [3, 67], [4, 28],[5, 38],[6, 40],[7, 17],[8, 45],[9, 43],[10,0],[11,0],[12, 0]];

            var plot = $.plot($("#statsChart"),
                [ { data: facebook, label: "Facebook"},
                 { data: twitter, label: "Twitter" },
				 { data: istagram, label: "Instagram"},
				 { data: frsquare, label: "Foursquare"}], {
                    series: {
                        lines: { show: true,
                                lineWidth: 1,
                                fill: true, 
                                fillColor: { colors: [ { opacity: 0.1 }, { opacity: 0.3 } ] }
                             },
                        points: { show: true, 
                                 lineWidth: 2,
                                 radius: 3
                             },
                        shadowSize: 0,
                        stack: false
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
                    colors: ["#a7b5c5", "#30a0eb",'#333333','#000000'],
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
                    }
                 });

            function showTooltip(x, y, contents) {
                $('<div id="tooltip">' + contents + '</div>').css( {
                    position: 'absolute',
                    display: 'none',
                    top: y - 30,
                    left: x - 50,
                    color: "#fff",
                    padding: '2px 5px',
                    'border-radius': '6px',
                    'background-color': '#000',
                    opacity: 0.80
                }).appendTo("body").fadeIn(200);
            }

            var previousPoint = null;
            $("#statsChart").bind("plothover", function (event, pos, item) {
                if (item) {
                    if (previousPoint != item.dataIndex) {
                        previousPoint = item.dataIndex;

                        $("#tooltip").remove();
                        var x = item.datapoint[0].toFixed(0),
                            y = item.datapoint[1].toFixed(0);

                        var month = item.series.xaxis.ticks[item.dataIndex].label;

                        showTooltip(item.pageX, item.pageY,
                                    item.series.label + " of " + month + ": " + y);
                    }
                }
                else {
                    $("#tooltip").remove();
                    previousPoint = null;
                }
            });
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
</body>
</html>