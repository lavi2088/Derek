<?php
session_start();
include_once 'dbconfig.php';
include 'GlobalFunction.php';
include 'w_dashboardConfig.php';
$tbl_name="userdetail"; // Table name

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

    <title><?php echo $appname; ?> - Notification</title>

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
            <h1><?php echo $appname; ?> <small>Notification</small></h1>
            <ol class="breadcrumb">
              <li><a href="w_dashboardhome.php"><i class="fa fa-dashboard"></i> Dashboard</a></li>
              <li class="active"><i class="fa fa-edit"></i> Notification</li>
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
		
		<div class="col-lg-12">
		<h3> Notification Center </h3>
             <hr />
             <form action="apns/NotifyAllUser_Service.php" enctype="multipart/form-data" method="post" id="notificationform" > 
			 <div class="form-group">
			 <div class="row">
             <div class="col-lg-6"><input type="text" class="form-control" placeholder="Notification message for all application users" name="msg" class="notifyText" /></div>
             <div class="col-lg-3"><input type="button" onclick="submitNotificationClicked()" value="SUBMIT" class="btn btn-success"/></div>
			 </div>
			 </div>
             </form>
		</div>
		
		<div class="table-responsive">
			<div class="col-lg-12">
				<table class="table table-hover tablesorter">
                            <thead>
                                <tr>
                                <th class="col-lg-1" colspan="1">
                                        Status
                                    </th>
                                    <th class="col-lg-2" colspan="1">
                                        User Name
                                    </th>
                                    <th class="col-lg-2" colspan="1">
                                        <span class="line"></span>Member Since
                                    </th>
                                    <th class="col-lg-2" colspan="1">
                                        <span class="line"></span> Point Redeemed
                                    </th>
									 <th class="col-lg-3" colspan="1">
                                        <span class="line"></span> Point Balance
                                    </th>
									<th class="col-lg-1" colspan="1">
                                        <span class="line"></span>History
                                    </th>
                                    <th class="col-lg-1" colspan="1">
                                        <span class="line"></span>Notify 
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


echo '<tr style="background-color:'.$colorCode.'"><td><img src="'.$iconStatus.'"></td><td  >'.$tableName[11].' '.$tableName[12].'</td>
<td >'.date("m-d-Y", strtotime($tableName[13])).'</td><td  >'.getTotalRedeemedData($tableName[0]).'&nbsp;&nbsp;</td>
<td >'.getTotalAccountPointsData($tableName[0]).'</td>
<td ><a href="UserHistory.php?userid='.$tableName[0].'" >History</a></td>
<td ><a href="NotifyUser.php?userid='.$tableName[0].'&val=1" >Notify User</a></td></tr>';

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
	
	//Jquery block
	$(document).ready(function(){
	
	
	$("#notificationform").submit(function(e)
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

function submitNotificationClicked()
{
	$("#notificationform").submit();
}
	</script>
</html>