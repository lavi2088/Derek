<?php
include 'dbconfig.php';
$tbl_name="sharepagedetail"; // Table name

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
echo "get userid".$_GET['userid'];
$userid=$_GET['userid'];
$username=rawurldecode($_GET['username']);
$socialtype=$_GET['socialtype'];
$sharedurl=$_GET['sharedurl'];
$bonuspoint=$_GET['bonuspoint'];
$postid=$_GET['postid'];

$sql="insert into sharepagedetail values('".$userid."','".$username."','".$socialtype."','".$sharedurl."','".$bonuspoint."','N',NOW(),'".$postid."')";
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