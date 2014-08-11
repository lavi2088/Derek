<?php
include 'dbconfig.php';
$tbl_name="activitylog"; // Table name

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
$activityId=$_GET['activityId'];
$userid=$_GET['userid'];
$firstname=$_GET['firstname'];
$lastname=$_GET['lastname'];
$socialtype=$_GET['socialtype'];
$activitytype=$_GET['activitytype'];
$activitytitle=rawurldecode($_GET['activitytitle']);
$activitydate=$_GET['activitydate'];
$expiredate=$_GET['expiredate'];
$amount=$_GET['amount'];
$redeempoint=$_GET['redeempoint'];
$status=$_GET['status'];

$sql="insert into activitylog values('".$activityId."','".$userid."','".$socialtype."','".$activitytype."','".$activitytitle."',DEFAULT,DEFAULT,'".$amount."','".$redeempoint."','".$status."')";
echo $sql;
$result=mysql_query($sql);

if($result){
echo "success";
}
else{
echo "".mysql_error();
}
mysql_close($conn);
?>