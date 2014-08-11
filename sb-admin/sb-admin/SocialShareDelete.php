<?php
include 'dbconfig.php';
// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
$id=$_GET['id'];
$sql="UPDATE tbl_socialpost SET isactive='0', addeddate=DEFAULT where id='".$id."'";
	echo $sql;
	$result=mysql_query($sql);

	if($result){
		echo "success";
		header("location: w_socialshare.php");
	}
	else{
		echo "".mysql_error();
	}

mysql_close($conn);
?>
