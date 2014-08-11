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
$payAmount=$payAmount-($servicepoint*5/100);
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
<h3>St-Hubert Payment</h3>
<h4>Product Name:</h4> <?php echo $tableName[1]; ?>
<br />
<h4>Amount:</h4> $<?php echo $payAmount; ?>
<br />
<h4>Duration : </h4>One Time 
<br />
<br />

<form action="https://www.sandbox.paypal.com/us/cgi-bin/webscr" method="post">
<input type="hidden" name="cmd" value="_xclick">
<input type="hidden" name="business" value="meetlavi6@gmail.com">
<input type="hidden" name="cbt" value="Click here to complete your purchase">
<input type="hidden" name="item_name" value="<?php echo $tableName[1]; ?>">
<input type="hidden" name="amount" value="<?php echo $payAmount; ?>">
<input type="hidden" name="no_shipping" value="1">
<input type="hidden" name="return" value="http://www.mymobipoints.com/tanningloft-app-services/paypal/order_confirm.php">
 <input type="hidden" name="cancel_return"
value="http://www.mymobipoints.com/tanningloft-app-services/paypal/order_cancel.php">
<input type="hidden" name="currency_code" value="USD">
<input type="hidden" name="lc" value="US">
<input type="hidden" name="bn" value="PP-BuyNowBF">
<div align="center">
<input type="image" src="buybutton1.png" border="0" name="submit" alt="Make your payments with PayPal. It is free, secure, effective.">
<img alt="" border="0" src="https://www.paypal.com/it_IT/i/scr/pixel.gif" width="1" height="1">
</div>
</form> 

</div>
</body>
</html>
