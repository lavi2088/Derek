<?php
include 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="sharepagedetail"; // Table name

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
echo "get userid".$_POST['userid'];
$userid=$_POST['userid'];

$sqlStmt="SELECT * FROM userdetail WHERE userid='".$userid."'";
$result1=mysql_query($sqlStmt);
$existingVal=0;
$tokenid='';
$notificationMsg='';
$userResultData= mysql_fetch_row($result1);
$tokenid=$userResultData[14];

$redeemPoints=$_POST['point'];
echo $redeemPoints."rrrr";
$totalPoints=getBonusAccountPointsData($userid);
echo $totalPoints."tttttt";
$totalPoints=$totalPoints+$redeemPoints;
echo $totalPoints."ffffff";
$sqlUpdate="";

$sqlUpdate="update userdetail set totalpoint=".$totalPoints." where userid='".$userid."'";
echo $sqlUpdate;
$result=mysql_query($sqlUpdate);

$sqlUpdateMessage="insert into tbl_message VALUES (DEFAULT,'".$userid."','You have been rewarded with ".$_POST['point']." points','You have been rewarded with ".$_POST['point']." points','M',DEFAULT,0,0,0,DEFAULT,1)";
echo $sqlUpdateMessage;
$resultBouns=mysql_query($sqlUpdateMessage);

mysql_close($conn);
$notificationMsg='You have been rewarded with '.$_POST['point'].' points';
echo $tokenid;
echo $notificationMsg;
header("Location: apns/simplepush.php?tokenid=".$tokenid."&msg=".$notificationMsg."&type=b");

?>	