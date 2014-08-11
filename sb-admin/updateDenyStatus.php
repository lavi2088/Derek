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

$sqlStmtUser="SELECT * FROM userdetail WHERE userid='$userid'";
$resultUser=mysql_query($sqlStmtUser);
$userResultDataUser= mysql_fetch_row($resultUser);
$tokenid='';
$tokenid=$userResultDataUser[14];

$sqlUpdateShare="update sharepagedetail set status='Y' where postid='".$postid."'";
$activityUpdate="update activitylog set status='D' where activityId='".$postid."'";

$sqlDenyShareStmt="SELECT * FROM sharepagedetail WHERE postid='$postid'";
$resultdeny=mysql_query($sqlDenyShareStmt);
$shareDenyResultData= mysql_fetch_row($resultdeny);

echo $sqlUpdate;
$result=mysql_query($sqlUpdateShare);
$activityresult=mysql_query($activityUpdate);
$notificationMsg="";
if($type=='F')
{
$notificationMsg="Facebbok Post Declined.Your ".$shareDenyResultData[4]." points will not be credited.";
}
else if($type=='T')
{
$notificationMsg="Twitter Tweet Declined.Your ".$shareDenyResultData[4]." points will not be credited.";
}
else if($type=='I')
{
$notificationMsg="Instagram Photo Declined.Your ".$shareDenyResultData[4]." points will not be credited.";
}
else if($type=='FR')
{
$notificationMsg="Foursquare Checkin Declined.Your ".$shareDenyResultData[4]." points will not be credited.";
}

if($result){

$sqlUpdateMessage="insert into tbl_message VALUES (DEFAULT,'".$userid."','".$notificationMsg."','".$notificationMsg."','M',DEFAULT,0,0,0,DEFAULT,1)";
echo $sqlUpdateMessage;
$resultBouns=mysql_query($sqlUpdateMessage);

echo "success";
header("Location: apns/simplepush.php?tokenid=".$tokenid."&msg=".$notificationMsg."");

}
else{
echo "".mysql_error();
}
mysql_close($conn);

?>	