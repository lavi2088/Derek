<?php
session_start();
include_once '../dbconfig.php';
include '../GlobalFunction.php';
$tbl_name="PackageDetails"; // Table name

// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$totalUserPoint=getTotalAccountPointsData(''.$_GET['userid']);
$servicepoint=$_GET['point'];

if($servicepoint>$totalUserPoint){
$servicepoint=$totalUserPoint;
}

$sql="SELECT * FROM $tbl_name where pkgId='".$_GET['id']."'";
$result=mysql_query($sql);
$tableName = mysql_fetch_row($result);
$payAmount=$tableName[5];
$payAmount=$payAmount-($servicepoint*5/100.0);
$errorMsg='';
if(isset($_GET['error']))
{
$errorMsg=$_GET['msg'];
}
?>

<html>
<head>
<link rel='stylesheet' href='style.css'>
</head>
<body>
<div class="container">
<h3>St-Hubert Subscription</h3>
<h4>Product Name:</h4> <?php echo $tableName[1]; ?>
<br />
<h4>Amount:</h4> $<?php echo $payAmount; ?>
<br />
<h4>Duration : </h4>Monthly Package
<br />
<br />
	<form action="https://www.sandbox.paypal.com/us/cgi-bin/webscr" method="post">
  <input type="hidden" name="cmd" value="_xclick-subscriptions">
  <input type="hidden" name="business" value="meetlavi6@gmail.com">
  <input type="hidden" name="cbt" value="Click here to complete your purchase">
  <input type="hidden" name="item_name" value="<?php echo $tableName[1]; ?>">
  <input type="hidden" name="item_number" value="<?php echo $tableName[0]; ?>">
  <input type="hidden" name="image_url"
value="https://www.yoursite.com/logo.gif">
  <input type="hidden" name="no_shipping" value="1">
  <input type="hidden" name="return"
value="http://www.mymobipoints.com/tanningloft-app-services/paypal/order_confirm.php">
  <input type="hidden" name="cancel_return"
value="http://www.mymobipoints.com/tanningloft-app-services/paypal/order_cancel.php">
  <input type="hidden" name="a3" value="<?php echo $payAmount; ?>"> 
  <input type="hidden" name="p3" value="12">
  <input type="hidden" name="t3" value="M">
  <input type="hidden" name="no_note" value="1">
  <div align="center">
  <input type="image" width="400px" height="100px" src="https://www.paypalobjects.com/en_US/i/btn/btn_subscribeCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
<img alt="" border="0" src="https://www.paypalobjects.com/webstatic/mktg/logo/AM_SbyPP_mc_vs_dc_ae.jpg" width="1" height="1" >
</div>
</form>

</div>

</body>
</html>
