<?php

include 'dbconfig.php';

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
$userid=$_GET['userid'];
$sqlUpdate="Update userdetail set isActiveUser=".$_GET['val']." WHERE userid='".$userid."'";
$result=mysql_query($sqlUpdate);
if($result)
{
	header('location:UserList.php');
}
mysql_close($conn);

?>	