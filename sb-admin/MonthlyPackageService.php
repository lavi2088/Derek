<?php
include 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="activitylog"; // Table name

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
$userid=$_GET['userid'];
$firstname=$_GET['firstname'];
$lastname=$_GET['lastname'];
$pkgtitle=rawurldecode( $_GET['pkgtitle'] );
$pkgdesc=rawurldecode($_GET['pkgdesc']);
$amount=$_GET['amount'];
$pointredeemed=$_GET['point'];
$pkgType=$_GET['pkgType'];
$pkgId=$_GET['pkgId'];
$pin=random_numbers(4);

$tomorrow = date("Y-m-d H:i:s", time() + 30*24*60*60);
  
//echo $tomorrow;
  
$sql="insert into MonthlyPackageUsers values('".$userid."','".$firstname."','".$lastname."','".$pkgtitle."','".$pkgdesc."',DEFAULT,'".$tomorrow."','".$amount."','".$pointredeemed."','".$pkgType."','".$pin."','".$tomorrow."',0,".$pkgId.")";
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