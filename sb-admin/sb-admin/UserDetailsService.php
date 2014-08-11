<?php

include 'dbconfig.php';
// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$userid=$_GET['userid'];
$format=$_GET['format'];

$sqlStmt="SELECT * FROM userdetail WHERE userid='$userid'";
$result1=mysql_query($sqlStmt);
$count=mysql_num_rows($result1);

if($count==0){
$sqlInsert="insert into userdetail values('".$userid."','','','','','0','0','0','0','0','0','','',DEFAULT,'','".$userid."','','1')";
$result2=mysql_query($sqlInsert);

$sqlStmt="SELECT * FROM userdetail WHERE userid='$userid'";
$result1=mysql_query($sqlStmt);

}
		
$posts = array();
if(mysql_num_rows($result1)) {
	while($post = mysql_fetch_assoc($result1)) {
		$posts[] = array('post'=>$post);
	}
}

/* output in necessary format */
if($format == 'json') {
	header('Content-type: application/json');
	echo json_encode(array('posts'=>$posts));
}

mysql_close($conn);

?>	