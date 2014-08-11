<?php
include 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="sharepagedetail"; // Table name

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
echo "get userid".$_POST['userid'];
$userid=$_POST['userid'];
$type=$_POST['type'];
$postid=$_POST['postid'];

$sqlUpdateShare="update lastSpinWheelDetail set date='0000-00-00 00:00:00'";
echo $sqlUpdate;
$result=mysql_query($sqlUpdateShare);
$notificationMsg="Your Spin Wheel is active, Spin and win points now...";

$tokenid='';

$sqlUpdateMessage="insert into tbl_message VALUES (DEFAULT,'".$userid."','".$notificationMsg."','".$notificationMsg."','M',DEFAULT,0,0,0,DEFAULT,1)";
echo $sqlUpdateMessage;
$resultBouns=mysql_query($sqlUpdateMessage);

header("Location: apns/SpinWheelPush.php");


mysql_close($conn);

?>	