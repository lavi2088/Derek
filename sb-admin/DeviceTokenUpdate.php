<?php

include 'dbconfig.php';

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$userid=$_GET['userid'];
$firstname=$_GET['firstname'];
$lastname=$_GET['lastname'];
$tokenId=$_GET['tokenid'];
$email=$_GET['email'];

$sqlStmt="SELECT * FROM userdetail WHERE userid='$userid'";
$result1=mysql_query($sqlStmt);

// Mysql_num_row is counting table row
$count=0;
$count=mysql_num_rows($result1);
$tableName = mysql_fetch_row($result1);
$currenttoken=$tableName[14];
// If result matched $myusername and $mypassword, table row must be 1 row


$sqlInsert="";
$sqlUpdate="";

$sqlInsert="insert into userdetail values('".$userid."','','','','','0','0','0','0','0','0','".$firstname."','".$lastname."',DEFAULT,'".$tokenId."','".$email."','','1')";

$sqlUpdate="Update userdetail set tokenid='".$tokenId."' WHERE userid='".$userid."'";
echo $sqlInsert;
echo $sqlUpdate;
if($count>0){
	if(strlen($tokenId)>5)
	{
		echo "Inside token update";
   		$result=mysql_query($sqlUpdate);
    }
    else{
    	echo "Inside token not update".strlen($tokenId);
    }
}
else{
   $result=mysql_query($sqlInsert);
}

mysql_close($conn);

?>	