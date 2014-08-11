<?php
session_start();
include_once 'dbconfig.php';
include 'GlobalFunction.php';
include 'w_dashboardConfig.php';
$tbl_name="SpinWheelSettingTable"; // Table name
$notifyStatus=$_GET['notifyStatus'];
if(!isset($_SESSION['myusername'])){
header("Location: http://mymobipoints.com/admin/index.html");
}
// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$sql="SELECT * FROM $tbl_name ";
$result=mysql_query($sql);

$vouchersql1="SELECT * FROM PackageDetails where pkgType='V'";
$voucherresult1=mysql_query($vouchersql1);

$vouchersql2="SELECT * FROM PackageDetails where pkgType='V'";
$voucherresult2=mysql_query($vouchersql2);

$vouchersql3="SELECT * FROM PackageDetails where pkgType='V'";
$voucherresult3=mysql_query($vouchersql3);

$vouchersql4="SELECT * FROM PackageDetails where pkgType='V'";
$voucherresult4=mysql_query($vouchersql4);

$vouchersql5="SELECT * FROM PackageDetails where pkgType='V'";
$voucherresult5=mysql_query($vouchersql5);

$vouchersql6="SELECT * FROM PackageDetails where pkgType='V'";
$voucherresult6=mysql_query($vouchersql6);

$vouchersql7="SELECT * FROM PackageDetails where pkgType='V'";
$voucherresult7=mysql_query($vouchersql7);

$vouchersql8="SELECT * FROM PackageDetails where pkgType='V'";
$voucherresult8=mysql_query($vouchersql8);

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
				<li class="active"><a href="SpinSetting.php"><i class="fa fa-table"></i> Spin Wheel</a></li>
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
				<h1><?php echo $appname; ?> <small>Spin Wheel</small></h1>
				<ol class="breadcrumb">
				  <li><a href="w_dashboardhome.php"><i class="fa fa-dashboard"></i> Dashboard</a></li>
				  <li class="active"><i class="fa fa-edit"></i> Spin Wheel</li>
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
				
<div class="row"><!-- Start Main container sample -->
<div class="col-lg-12">  <!--Add new Package container -->
 <h3>Spin Wheel Details:</h3>
 <hr />

<div class="col-lg-12">
            
            <div class="table-responsive">
<table class="table tablesorter">
                            <thead>
                                <tr>   
                                    <th >
                                        <span class="line"></span>Points 1
                                    </th>
                                    <th >
                                        <span class="line"></span>Points 2
                                    </th>
                                    <th >
                                        <span class="line"></span>Points 3
                                    </th>
									 <th >
                                        <span class="line"></span>Points 4
                                    </th>
									 <th >
                                        <span class="line"></span>Points 5
                                    </th>
									 <th >
                                        <span class="line"></span>Points 6
                                    </th>
									<th  >
                                        <span class="line"></span>Points 7
                                    </th>
									<th >
                                        <span class="line"></span>Points 8
                                    </th>
									<th >
                                        <span class="line"></span>Edit
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
								
<?php
$counter=0;
$colorCode="";
while($tableName = mysql_fetch_row($result)) {
$column1=$tableName[0];
$column2=$tableName[1];
$column3=$tableName[2];
$column4=$tableName[3];
$column5=$tableName[4];
$column6=$tableName[5];
$column7=$tableName[6];
$column8=$tableName[7];
$voucherValue=0;

if(!is_numeric($column1))
{
$voucherValue=substr($column1, 0, strlen($column1)-1);

$spinVoucher1="SELECT * FROM PackageDetails where pkgId='".$voucherValue."'";
$spinVoucherresult1=mysql_query($spinVoucher1);
$voucherTitleRes1 = mysql_fetch_row($spinVoucherresult1);

$column1="Free Voucher ".$voucherTitleRes1[1]." $".$voucherValue;
} 
else if($column1==0){
	$column1="Sorry";
}

if(!is_numeric($column2))
{
$voucherValue=substr($column2, 0, strlen($column2)-1);

$spinVoucher1="SELECT * FROM PackageDetails where pkgId='".$voucherValue."'";
$spinVoucherresult1=mysql_query($spinVoucher1);
$voucherTitleRes1 = mysql_fetch_row($spinVoucherresult1);

$column2="Free Voucher ".$voucherTitleRes1[1]." $".$voucherValue;
}
else if($column2==0){
	$column2="Sorry";
}

if(!is_numeric($column3))
{
$voucherValue=substr($column3, 0, strlen($column3)-1);
$spinVoucher1="SELECT * FROM PackageDetails where pkgId='".$voucherValue."'";
$spinVoucherresult1=mysql_query($spinVoucher1);
$voucherTitleRes1 = mysql_fetch_row($spinVoucherresult1);

$column3="Free Voucher ".$voucherTitleRes1[1]." $".$voucherValue;
}
else if($column3==0){
	$column3="Sorry";
}

if(!is_numeric($column4))
{
$voucherValue=substr($column4, 0, strlen($column4)-1);
$spinVoucher1="SELECT * FROM PackageDetails where pkgId='".$voucherValue."'";
$spinVoucherresult1=mysql_query($spinVoucher1);
$voucherTitleRes1 = mysql_fetch_row($spinVoucherresult1);

$column4="Free Voucher ".$voucherTitleRes1[1]." $".$voucherValue;
}
else if($column4==0){
	$column4="Sorry";
}

if(!is_numeric($column5))
{
$voucherValue=substr($column5, 0, strlen($column5)-1);
$spinVoucher1="SELECT * FROM PackageDetails where pkgId='".$voucherValue."'";
$spinVoucherresult1=mysql_query($spinVoucher1);
$voucherTitleRes1 = mysql_fetch_row($spinVoucherresult1);

$column5="Free Voucher ".$voucherTitleRes1[1]." $".$voucherValue;
}
else if($column5==0){
	$column5="Sorry";
}

if(!is_numeric($column6))
{
$voucherValue=substr($column6, 0, strlen($column6)-1);
$spinVoucher1="SELECT * FROM PackageDetails where pkgId='".$voucherValue."'";
$spinVoucherresult1=mysql_query($spinVoucher1);
$voucherTitleRes1 = mysql_fetch_row($spinVoucherresult1);

$column6="Free Voucher ".$voucherTitleRes1[1]." $".$voucherValue;
}
else if($column6==0){
	$column6="Sorry";
}

if(!is_numeric($column7))
{
$voucherValue=substr($column7, 0, strlen($column7)-1);
$spinVoucher1="SELECT * FROM PackageDetails where pkgId='".$voucherValue."'";
$spinVoucherresult1=mysql_query($spinVoucher1);
$voucherTitleRes1 = mysql_fetch_row($spinVoucherresult1);

$column7="Free Voucher ".$voucherTitleRes1[1]." $".$voucherValue;
}
else if($column7==0){
	$column7="Sorry";
}

if(!is_numeric($column8))
{
$voucherValue=substr($column8, 0, strlen($column8)-1);
$spinVoucher1="SELECT * FROM PackageDetails where pkgId='".$voucherValue."'";
$spinVoucherresult1=mysql_query($spinVoucher1);
$voucherTitleRes1 = mysql_fetch_row($spinVoucherresult1);

$column8="Free Voucher ".$voucherTitleRes1[1]." $".$voucherValue;
}
else if($column8==0){
	$column8="Sorry";
}

echo '<tr style="background-color:#666666; color:#ffffff;"><td width=12% style="padding-left:10px; color:#ffffff;">'.$column1.'</td>
<td width=12% align="left" style=" color:#ffffff;">'.$column2.'&nbsp;&nbsp;</td><td width=12% style=" color:#ffffff;">'.$column3.'</td>
<td width=12% style=" color:#ffffff;">'.$column4.'</td><td width=12% style=" color:#ffffff;">'.$column5.'</td>
<td width=12% style=" color:#ffffff;">'.$column6.'</td><td width=12% style=" color:#ffffff;">'.$column7.'</td>
<td width=12% style=" color:#ffffff;">'.$column8.'</td><td><input type="button" value="Update" id="UpdateBtn" class="btn btn-warning" onclick="UpdateButtonClicked();" /></td></tr>';

}

?>
                            </tbody>
                        </table>
					</div>
				</div>
						

</div><!--End of Add new package container -->

</div><!-- end Main container sample -->						

<div class="col-lg-12" id="UpdateDiv">	<!-- spinwheel update row -->					
<form enctype="multipart/form-data" role="form" action="UpdateSpinSetting.php" method="post" id="spinPointform" >
<div class="form-group">
<div class="row">
<div class="col-lg-12">
				<div class="col-lg-1"> Point 1</div>
				<div class="col-lg-3"> <select class="form-control" name="SPoint1" id="SPoint1" onchange="toggleBox('1');"><option value="P">Point</option><option value="V">Voucher</option><option value="S">Sorry</option></select></div>
				<div class="col-lg-3"><input class="form-control" type="text" id='Point1' name="Point1"/></div>
				<div class="col-lg-3"> 
				<select class="form-control" name="voucheroption1" style="display:none;" id="voucheroption1">
				<option value="select">Select</option>
				<?php 
				while($voucherName = mysql_fetch_row($voucherresult1))
				{
					echo "<option value='".$voucherName[0]."' >".$voucherName[1]."</option>";
				}
				 ?> 
				</select>
				</div>
</div>
</div>
</div>

<div class="form-group">
<div class="row">
<div class="col-lg-12">
				<div class="col-lg-1"> Point 2</div>
				<div class="col-lg-3"> <select class="form-control" name="SPoint2" id="SPoint2" onchange="toggleBox('2');"><option value="P">Point</option><option value="V">Voucher</option><option value="S">Sorry</option></select></div>
				<div class="col-lg-3"><input class="form-control" type="text" id='Point2' name="Point2"/></div>
				<div class="col-lg-3"> 
				<select class="form-control" name="voucheroption2" style="display:none;" id="voucheroption2">
				<option value="select">Select</option>
				<?php 
				while($voucherName = mysql_fetch_row($voucherresult2))
				{
					echo "<option value='".$voucherName[0]."' >".$voucherName[1]."</option>";
				}
				 ?> 
				</select>
				</div>
</div>
</div>	
</div>

<div class="form-group">
<div class="row">
<div class="col-lg-12">
				<div class="col-lg-1"> Point 3</div>
				<div class="col-lg-3"> <select class="form-control" name="SPoint3" id="SPoint3" onchange="toggleBox('3');"><option value="P">Point</option><option value="V">Voucher</option><option value="S">Sorry</option></select></div>
				<div class="col-lg-3"><input class="form-control" type="text" id='Point3' name="Point3"/></div>
				<div class="col-lg-3"> 
				<select class="form-control" name="voucheroption3" style="display:none;" id="voucheroption3">
				<option value="select">Select</option>
				<?php 
				while($voucherName = mysql_fetch_row($voucherresult3))
				{
					echo "<option value='".$voucherName[0]."' >".$voucherName[1]."</option>";
				}
				 ?> 
				</select>
				</div>
</div>
</div>
</div>

<div class="form-group">
<div class="row">
<div class="col-lg-12">
				<div class="col-lg-1"> Point 4</div>
				<div class="col-lg-3"> <select class="form-control" name="SPoint4" id="SPoint4" onchange="toggleBox('4');"><option value="P">Point</option><option value="V">Voucher</option><option value="S">Sorry</option></select></div>
				<div class="col-lg-3"><input class="form-control" type="text" id='Point4' name="Point4"/></div>
				<div class="col-lg-3"> 
				<select class="form-control" name="voucheroption4" style="display:none;" id="voucheroption4">
				<option value="select">Select</option>
				<?php 
				while($voucherName = mysql_fetch_row($voucherresult4))
				{
					echo "<option value='".$voucherName[0]."' >".$voucherName[1]."</option>";
				}
				 ?> 
				</select>
				</div>
</div>
</div>					
</div>

<div class="form-group">
<div class="row">
<div class="col-lg-12">
				<div class="col-lg-1"> Point 5</div>
				<div class="col-lg-3"> <select class="form-control" name="SPoint5" id="SPoint5" onchange="toggleBox('5');"><option value="P">Point</option><option value="V">Voucher</option><option value="S">Sorry</option></select></div>
				<div class="col-lg-3"><input class="form-control" type="text" id='Point5' name="Point5"/></div>
				<div class="col-lg-3"> 
				<select class="form-control" name="voucheroption5" style="display:none;" id="voucheroption5">
				<option value="select">Select</option>
				<?php 
				while($voucherName = mysql_fetch_row($voucherresult5))
				{
					echo "<option value='".$voucherName[0]."' >".$voucherName[1]."</option>";
				}
				 ?> 
				</select>
				</div>
</div>
</div>		
</div>

<div class="form-group">
<div class="row">
<div class="col-lg-12">
				<div class="col-lg-1"> Point 6</div>
				<div class="col-lg-3"> <select class="form-control" name="SPoint6" id="SPoint6" onchange="toggleBox('6');"><option value="P">Point</option><option value="V">Voucher</option><option value="S">Sorry</option></select></div>
				<div class="col-lg-3"><input class="form-control" type="text" id='Point6' name="Point6"/></div>
				<div class="col-lg-3"> 
				<select class="form-control" name="voucheroption6" style="display:none;" id="voucheroption6">
				<option value="select">Select</option>
				<?php 
				while($voucherName = mysql_fetch_row($voucherresult6))
				{
					echo "<option value='".$voucherName[0]."' >".$voucherName[1]."</option>";
				}
				 ?> 
				</select>
				</div>
</div>
</div>
</div>

<div class="form-group">
<div class="row">
<div class="col-lg-12">
				<div class="col-lg-1"> Point 7</div>
				<div class="col-lg-3"> <select class="form-control" name="SPoint7" id="SPoint7" onchange="toggleBox('7');"><option value="P">Point</option><option value="V">Voucher</option><option value="S">Sorry</option></select></div>
				<div class="col-lg-3"><input class="form-control" type="text" id='Point7' name="Point7"/></div>
				<div class="col-lg-3"> 
				<select class="form-control" name="voucheroption7" style="display:none;" id="voucheroption7">
				<option value="select">Select</option>
				<?php 
				while($voucherName = mysql_fetch_row($voucherresult7))
				{
					echo "<option value='".$voucherName[0]."' >".$voucherName[1]."</option>";
				}
				 ?> 
				</select>
				</div>
</div>
</div>				
</div>

<div class="form-group">
<div class="row">
<div class="col-lg-12">
				<div class="col-lg-1"> Point 8</div>
				<div class="col-lg-3"> <select class="form-control" name="SPoint8" id="SPoint8" onchange="toggleBox('8');"><option value="P">Point</option><option value="V">Voucher</option><option value="S">Sorry</option></select></div>
				<div class="col-lg-3"><input class="form-control" type="text" id='Point8' name="Point8"/></div>
				<div class="col-lg-3"> 
				<select class="form-control" name="voucheroption8" style="display:none;" id="voucheroption8">
				<option value="select">Select</option>
				<?php 
				while($voucherName = mysql_fetch_row($voucherresult8))
				{
					echo "<option value='".$voucherName[0]."' >".$voucherName[1]."</option>";
				}
				 ?> 
				</select>
				</div>
</div>
</div>		
</div>

<input type="button" value="SUBMIT" class="btn btn-success" onclick="submitSpinClicked()"/><span>&nbsp; &nbsp;<input type="button" value="CANCEL" class="btn btn-danger" onclick="CancelButtonClicked();"/></span>
</form>
</div><!-- end spinwheel update row -->

<div class="col-lg-8">
	   <h3>Spin Wheel Notification:</h3>
	   <div  class="NotifyWheel">Send a bonus spin-wheel opportunity to all your app users!&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="btn btn-primary" value="Send bonus spin" class="notifyBtn" onclick="document.location.href='NotifySpinWheelSetting.php'" /> </div>
</div>

<div class="col-lg-8">
<h1></h1>
<h1></h1>
</div>	   
		  </div><!-- /#page-wrapper -->

		</div><!-- /#wrapper -->
		<!-- JavaScript -->
		<script src="js/jquery-1.10.2.js"></script>
		<script src="js/bootstrap.js"></script>

	  </body>
		
		<script type="text/javascript">
	
	
	//Jquery block
	$(document).ready(function(){
	$('input[rel="txtTooltip"]').tooltip();
//Social share post form
$("#spinPointform").submit(function(e)
{
	//alert("sumit");
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
				//alert(data);
				if(obj.responsestatus==1)
				{
					alert(obj.msg);
					location.reload();;
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

function submitSpinClicked()
{
	$("#spinPointform").submit();
}



  var notifyStatus='<?php echo $notifyStatus ; ?>';
  function loadDefaultValue(){
  document.getElementById('UpdateDiv').hidden=true;
	if(notifyStatus=='Y')
	{
		alert('Spin Wheel Notification Done.');
	}
  }
	function UpdateButtonClicked(){
		$('#UpdateDiv').fadeIn("slow");
	}
	
	function CancelButtonClicked(){
		$('#UpdateDiv').fadeOut("slow");
	}
	
	function validate(){
	
	if(document.getElementById('Point1').value.length && document.getElementById('Point2').value.length && 
	document.getElementById('Point3').value.length && document.getElementById('Point4').value.length && 
	document.getElementById('Point5').value.length && document.getElementById('Point6').value.length)
	{
		return true;
	}
	else{
	alert("Please fill the form completely.");
	return false;
	}
	}
	
	function toggleBox(val){
	
		if(val=="1")
		{
			if(document.getElementById('SPoint1').value=="V")
			{
				document.getElementById("voucheroption1").style.display="block";
			}
			else{
				document.getElementById("voucheroption1").style.display="none";
			}
		}
		
		if(val=="2")
		{
			if(document.getElementById('SPoint2').value=="V")
			{
				document.getElementById("voucheroption2").style.display="block";
			}
			else{
				document.getElementById("voucheroption2").style.display="none";
			}
		}
		
		if(val=="3")
		{
			if(document.getElementById('SPoint3').value=="V")
			{
				document.getElementById("voucheroption3").style.display="block";
			}
			else{
				document.getElementById("voucheroption3").style.display="none";
			}
		}
		
		if(val=="4")
		{
			if(document.getElementById('SPoint4').value=="V")
			{
				document.getElementById("voucheroption4").style.display="block";
			}
			else{
				document.getElementById("voucheroption4").style.display="none";
			}
		}
		
		if(val=="5")
		{
			if(document.getElementById('SPoint5').value=="V")
			{
				document.getElementById("voucheroption5").style.display="block";
			}
			else{
				document.getElementById("voucheroption5").style.display="none";
			}
		}
		
		if(val=="6")
		{
			if(document.getElementById('SPoint6').value=="V")
			{
				document.getElementById("voucheroption6").style.display="block";
			}
			else{
				document.getElementById("voucheroption6").style.display="none";
			}
		}
		
		if(val=="7")
		{
			if(document.getElementById('SPoint7').value=="V")
			{
				document.getElementById("voucheroption7").style.display="block";
			}
			else{
				document.getElementById("voucheroption7").style.display="none";
			}
		}
		
		if(val=="8")
		{
			if(document.getElementById('SPoint8').value=="V")
			{
				document.getElementById("voucheroption8").style.display="block";
			}
			else{
				document.getElementById("voucheroption8").style.display="none";
			}
		}
	}
	loadDefaultValue();
   
		</script>
</html>