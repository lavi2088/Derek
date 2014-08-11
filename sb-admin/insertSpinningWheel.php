<?php
include 'dbconfig.php';
$tbl_name="sharepagedetail"; // Table name

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
echo "get userid".$_GET['userid'];
$userid=$_GET['userid'];

$point=$_GET['point'];

$sqlStmt="SELECT * FROM lastSpinWheelDetail WHERE userid='$userid'";
$result1=mysql_query($sqlStmt);



$updateValue=intval($point)+intval($existingVal);
$sqlInsert="insert into lastSpinWheelDetail values('".$userid."',DEFAULT,'".$point."')";
$sqlUpdate="update lastSpinWheelDetail set point='".$point."', date=DEFAULT where userid='".$userid."'";

$count=mysql_num_rows($result1);

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