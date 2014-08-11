<?php
include 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="MonthlyPackageUsers"; // Table name

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$userid=$_GET['userid'];
$pin=$_GET['pin'];
$pkgId=$_GET['pkgId'];

$sql="SELECT * FROM MonthlyPackageUsers where userid='".$userid."' and pin='".$pin."' and pkgId='".$pkgId."'";
$result=mysql_query($sql);
$tableName = mysql_fetch_row($result);
//echo $sql;
if(mysql_num_rows($result))
{
	$sqlupdate="update MonthlyPackageUsers SET isRedeemed=1, redeemdate=NOW(), expirydate=NOW() where userid='".$userid."' and pin='".$pin."' and pkgId='".$pkgId."'";
	$result=mysql_query($sqlupdate);
	 echo '{"success":"200","responsestatus":1, "pin":"'.$pin.'", "pkgId":"'.$pkgId.'"}';
}
else{
	echo '{"error":"101","responsestatus":2, "pin":"'.$pin.'"}';
}
?>