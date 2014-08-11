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

$sqlStmt="SELECT * FROM userdetail WHERE userid='$userid'";
$result1=mysql_query($sqlStmt);

$sqlShareStmt="SELECT * FROM sharepagedetail WHERE postid='$postid'";
$result2=mysql_query($sqlShareStmt);
$shareResultData= mysql_fetch_row($result2);

$existingVal=0;
$tokenid='';
$notificationMsg='';
while($userResultData= mysql_fetch_row($result1))
{
if($type=='F')
{
$existingVal=$userResultData[5];
$point=$shareResultData[4];
$notificationMsg="Facebook Post Approved.You won ".$shareResultData[4]." points";
}
else if($type=='T')
{
$existingVal=$userResultData[6];
$point=$shareResultData[4];
$notificationMsg="Twitter Tweet Approved.You won ".$shareResultData[4]." points";
}
else if($type=='I')
{
$existingVal=$userResultData[7];
$point=$shareResultData[4];
$notificationMsg="Instagram Photo Approved.You won ".$shareResultData[4]." points";
}
else if($type=='FR')
{
$existingVal=$userResultData[8];
$point=$shareResultData[4];
$notificationMsg="Foursquare Checkin Approved.You won ".$shareResultData[4]." points";
}
else if($type=='SP')
{
$point=0;
$existingVal=$userResultData[9];
}

$tokenid=$userResultData[14];
}

echo "updateValue ".$updateValue;
// Mysql_num_row is counting table row
$count=mysql_num_rows($result1);
// If result matched $myusername and $mypassword, table row must be 1 row
//$point=$_POST['point'];
$sqlInsert="";
$sqlUpdate="";
$sqlUpdateShare="update sharepagedetail set status='Y' where postid='".$postid."'";
$activityUpdate="update activitylog set status='A' where activityId='".$postid."'";
if($type=='F')
{
//$point=5;
$updateValue=intval($point)+intval($existingVal);
$sqlInsert="insert into userdetail values('".$userid."','','','','','".$point."','0','0','0','0','".point."','','','','','')";
$sqlUpdate="update userdetail set fbpoint='".$updateValue."' where userid='".$userid."'";

}
else if($type=='T')
{
//$point=4;
$updateValue=intval($point)+intval($existingVal);
$sqlInsert="insert into userdetail values('".$userid."','','','','','0','".$point."','0','0','0','".point."','','','','','')";
$sqlUpdate="update userdetail set twpoint='".$updateValue."' where userid='".$userid."'";
}
else if($type=='I')
{
//$point=3;
$updateValue=intval($point)+intval($existingVal);
$sqlInsert="insert into userdetail values('".$userid."','','','','','0','0','".$point."','0','0','".point."','','','','','')";
$sqlUpdate="update userdetail set istpoint='".$updateValue."' where userid='".$userid."'";
}
else if($type=='FR')
{
//$point=6;
$updateValue=intval($point)+intval($existingVal);
$sqlInsert="insert into userdetail values('".$userid."','','','','','0','0','0','".$point."','0','".point."','','','','','')";
$sqlUpdate="update userdetail set fourpoint='".$updateValue."' where userid='".$userid."'";
}
else if($type=='SP')
{
//$point=6;
$updateValue=intval($point)+intval($existingVal);
$sqlInsert="insert into userdetail values('".$userid."','','','','','0','0','0','0','".$point."','".point."','','','','','')";
$sqlUpdate="update userdetail set spinpoint='".$updateValue."' where userid='".$userid."'";
}

if($count>0){


echo $sqlUpdate;
$result=mysql_query($sqlUpdate);

if($result){
echo "success";
$result=mysql_query($sqlUpdateShare);
$activityresult=mysql_query($activityUpdate);

}
else{
echo "".mysql_error();
}


}
else{

echo $sqlInsert;
$result=mysql_query($sqlInsert);


if($result){
echo "success";
$result=mysql_query($sqlUpdateShare);
$activityresult=mysql_query($activityUpdate);
}
else{
echo "".mysql_error();
}


}

$sqlUpdateMessage="insert into tbl_message VALUES (DEFAULT,'".$userid."','".$notificationMsg."','".$notificationMsg."','M',DEFAULT,0,0,0,DEFAULT,1)";
echo $sqlUpdateMessage;
$resultBouns=mysql_query($sqlUpdateMessage);

//$r = new HttpRequest("http://myriadim.com/mobile-app-services/apns/simplepush.php?tokenid=".$tokenid."&msg=".$notificationMsg, HttpRequest::METH_GET);
header("Location: apns/simplepush.php?tokenid=".$tokenid."&msg=".$notificationMsg."");

mysql_close($conn);

?>	