<?php
include 'dbconfig.php';
$tbl_name="sharepagedetail"; // Table name

// Connect to server and select databse.

$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name") or die("cannot select DB");

$value1=$_POST['Point1'];
$value2=$_POST['Point2'];
$value3=$_POST['Point3'];
$value4=$_POST['Point4'];
$status=1;
$msg="";
if(!is_numeric($value1))
{
	$status=0;
	$msg="Facebook point value should be number.";
}
else if(!is_numeric($value2))
{
	$status=0;
	$msg="Twitter point value should be number.";
}
else if(!is_numeric($value3))
{
	$status=0;
	$msg="Instagram point value should be number.";
}
else if(!is_numeric($value4))
{
	$status=0;
	$msg="Foursquare point value should be number.";
}


$sql="update SocialPointsDetails set FacebookPoints='".$value1."', TwitterPoints='".$value2."', InstagramPoints='".$value3."', FourSquarePoints='".$value4."', UpdatedDate=DEFAULT";
//echo $sql;
$result=mysql_query($sql);
if($status)
{
	if($result){
		echo '{"responsestatus":"1", "msg": "Updated successfully."}';
		//header('Location: SocialShare.php?responsestatus=1&msg=Updated successfully');
	}
	else{
		echo '{"responsestatus":"2", "msg": "Technical error occured, please contact to admin."}';
		//header('Location: SocialShare.php?responsestatus=2&msg=Technical error occured, please contact to admin.');
	}
}
else{
	echo '{"responsestatus":"2", "msg": "'.$msg.'"}';
	//header('Location: SocialShare.php?responsestatus=2&msg='.$msg);
}

mysql_close($conn);

?>