<?php
include 'dbconfig.php';
$tbl_name="sharepagedetail"; // Table name

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
echo "get userid".$_GET['userid'];
$userid=$_GET['userid'];
$type=$_GET['type'];
$postid=$_GET['postid'];

$sqlStmt="SELECT * FROM userdetail WHERE userid='$userid'";
$result1=mysql_query($sqlStmt);
$existingVal=0;
while($userResultData= mysql_fetch_row($result1))
{
if($type=='F')
{
$existingVal=$userResultData[5];
}
else if($type=='T')
{
$existingVal=$userResultData[6];
}
else if($type=='I')
{
$existingVal=$userResultData[7];
}
else if($type=='FR')
{
$existingVal=$userResultData[8];
}
else if($type=='SP')
{
$existingVal=$userResultData[9];
}

}

echo "updateValue ".$updateValue;
// Mysql_num_row is counting table row
$count=mysql_num_rows($result1);
// If result matched $myusername and $mypassword, table row must be 1 row
$point=$_GET['point'];;
$sqlInsert="";
$sqlUpdate="";
$sqlUpdateShare="update sharepagedetail set status='Y' where postid='".$postid."'";
if($type=='F')
{
//$point=5;
$updateValue=intval($point)+intval($existingVal);
$sqlInsert="insert into userdetail values('".$userid."','','','','','".$point."','0','0','0','0','".point."')";
$sqlUpdate="update userdetail set fbpoint='".$updateValue."' where userid='".$userid."'";

}
else if($type=='T')
{
//$point=4;
$updateValue=intval($point)+intval($existingVal);
$sqlInsert="insert into userdetail values('".$userid."','','','','','0','".$point."','0','0','0','".point."')";
$sqlUpdate="update userdetail set twpoint='".$updateValue."' where userid='".$userid."'";
}
else if($type=='I')
{
//$point=3;
$updateValue=intval($point)+intval($existingVal);
$sqlInsert="insert into userdetail values('".$userid."','','','','','0','0','".$point."','0','0','".point."')";
$sqlUpdate="update userdetail set istpoint='".$updateValue."' where userid='".$userid."'";
}
else if($type=='FR')
{
//$point=6;
$updateValue=intval($point)+intval($existingVal);
$sqlInsert="insert into userdetail values('".$userid."','','','','','0','0','0','".$point."','0','".point."')";
$sqlUpdate="update userdetail set fourpoint='".$updateValue."' where userid='".$userid."'";
}
else if($type=='SP')
{
//$point=6;
$updateValue=intval($point)+intval($existingVal);
$sqlInsert="insert into userdetail values('".$userid."','','','','','0','0','0','0','".$point."','".point."')";
$sqlUpdate="update userdetail set spinpoint='".$updateValue."' where userid='".$userid."'";
}

if($count>0){


echo $sqlUpdate;
$result=mysql_query($sqlUpdate);

if($result){
echo "success";
$result=mysql_query($sqlUpdateShare);
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
}
else{
echo "".mysql_error();
}


}



mysql_close($conn);

?>	