<?php

include 'dbconfig.php';
// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$userid=$_GET['userid'];
$format=$_GET['format'];
$fname=$_GET['fname'];
$lname=$_GET['lname'];
$token=$_GET['token'];

if(strlen($token)>1)
{
$sqlStmt="update userdetail set firstname='$fname', lastname='$lname', tokenid='$token' WHERE userid='$userid'";
}
else{
$sqlStmt="update userdetail set firstname='$fname', lastname='$lname' WHERE userid='$userid'";
}
echo $sqlStmt;
$result1=mysql_query($sqlStmt);
echo $result1;
mysql_close($conn);

?>	