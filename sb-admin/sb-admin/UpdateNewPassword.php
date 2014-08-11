
<?php

include 'dbconfig.php';

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$email=$_POST['userid'];
$password=$_POST['password1'];


$sqlUpdate="";


$sqlUpdate="Update userdetail set password='".$password."' WHERE userid='".$email."'";

$result=mysql_query($sqlUpdate);

if($result){
   
   echo '{"error":"101","responsestatus":1}';
   
  header("location:setnewpassword.php?status=1");
}
else{
   //$result=mysql_query($sqlInsert);
   echo '{"error":"101","responsestatus":2}';
}


mysql_close($conn);

?>	