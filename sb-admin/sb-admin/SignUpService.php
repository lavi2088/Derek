<?php

include 'dbconfig.php';

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$userid=$_GET['userid'];
$firstname=$_GET['firstname'];
$lastname=$_GET['lastname'];
$tokenId=$_GET['tokenid'];
$password=$_GET['password'];
$email=$_GET['email'];
$state=$_GET['state'];
$format=$_GET['format'];
if($state=="LOGIN")
	$sqlStmt="SELECT * FROM userdetail WHERE userid='$userid' AND password='$password'";
else
	$sqlStmt="SELECT * FROM userdetail WHERE userid='$userid'";
$result1=mysql_query($sqlStmt);

// Mysql_num_row is counting table row

$count=mysql_num_rows($result1);

// If result matched $myusername and $mypassword, table row must be 1 row


$sqlInsert="";
$sqlUpdate="";

$sqlInsert="insert into userdetail values('".$userid."','','','','','0','0','0','0','0','0','".$firstname."','".$lastname."',DEFAULT,'".$tokenId."','".$email."','".$password."','1')";

$sqlUpdate="Update userdetail set tokenid='".$tokenId."' WHERE userid='".$userid."'";

if($count>0){
  // $result=mysql_query($sqlUpdate);
}
else{
   //$result=mysql_query($sqlInsert);
}

if($state=="LOGIN")
{
	if($count>0)
	{
		//echo "{'msg':'success','responsestatus':1}";
		$result=mysql_query($sqlInsert);
		//echo "{'msg':'success','responsestatus':1}";
		$sql="SELECT * FROM userdetail WHERE userid='$userid'";
		$outresult=mysql_query($sql);
		
  /* create one master array of the records */
		$posts = array();
		if(mysql_num_rows($outresult)) {
			while($post = mysql_fetch_assoc($outresult)) {
				$posts[] = array('post'=>$post);
			}
		}

		/* output in necessary format */
		if($format == 'json') {
			header('Content-type: application/json');
			echo json_encode(array('posts'=>$posts));
		}
	}
	else{
		echo '{"error":"101","responsestatus":2}';
	}
}
else if($state=="SIGNUP"){
	if($count==0)
	{
		$result=mysql_query($sqlInsert);
		//echo "{'msg':'success','responsestatus':1}";
		$sql="SELECT * FROM userdetail WHERE userid='$userid'";
		$outresult=mysql_query($sql);
  
  /* create one master array of the records */
		$posts = array();
		if(mysql_num_rows($outresult)) {
			while($post = mysql_fetch_assoc($outresult)) {
				$posts[] = array('post'=>$post);
			}
		}

		/* output in necessary format */
		if($format == 'json') {
			header('Content-type: application/json');
			echo json_encode(array('posts'=>$posts));
		}
	}
	else{
		echo '{"error":"102","responsestatus":2}';
	}
}
else{
}
mysql_close($conn);

?>	