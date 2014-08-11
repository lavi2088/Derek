<?php
include 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="sharepagedetail"; // Table name

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
echo "get userid".$_GET['userid'];
$userid=$_GET['userid'];
$redeemPoints=$_GET['point'];
$totalPoints=getTotalAccountPointsData($userid);
$totalPoints=$totalPoints-$redeemPoints;
$sqlUpdate="";

$sqlUpdate="update userdetail set fbpoint='0', twpoint='0', istpoint='0', fourpoint='0', spinpoint='0', totalpoint=".$totalPoints." where userid='".$userid."'";
echo $sqlUpdate;
$result=mysql_query($sqlUpdate);

mysql_close($conn);

?>	