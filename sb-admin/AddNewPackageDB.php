<?php
include 'dbconfig.php';
// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
$title=$_POST['title'];
$level=$_POST['level'];
$desc=$_POST['desc'];
$point=$_POST['points'];
$amount=$_POST['amount'];
$isactive=$_POST['isactive'];
$type=$_POST['type'];
$pkgDuration=$_POST['pkgDuration'];

//******Error msg ****/

$msg100="Technical error occured, please contact to admin.";
$msg101="Please use image of type jpeg, jpg, png and image size should not exceed 2 MB.";
$msg102="Image name should not contain spaces .";
$msg103="Please use image of type jpeg, jpg, png.";
$msg104="Please use image of type jpeg, jpg, png.";

$status=1;
$msg="";

if($type=="B")
{
$title=$level."$^^^$".$title;
}
$allowedExts = array("gif", "jpeg", "jpg", "png");
$temp = explode(".", $_FILES["file"]["name"]);
$extension = end($temp);
if ((($_FILES["file"]["type"] == "image/gif")
|| ($_FILES["file"]["type"] == "image/jpeg")
|| ($_FILES["file"]["type"] == "image/jpg")
|| ($_FILES["file"]["type"] == "image/pjpeg")
|| ($_FILES["file"]["type"] == "image/x-png")
|| ($_FILES["file"]["type"] == "image/png"))
&& ($_FILES["file"]["size"] < 20000*10*10)
&& in_array($extension, $allowedExts))
  {
  if ($_FILES["file"]["error"] > 0)
    {
		if($status==1)
		{
			$status=0;
			$msg=$msg101;
		}
    }
  else
    {
      move_uploaded_file($_FILES["file"]["tmp_name"],
      "upload/" . $_FILES["file"]["name"]);
	  
	  //Validation
	  if(!strlen($title))
		{
			if($status==1)
			{
				$status=0;
				$msg="Title cannot be blank.";
			}
		}
		else if(!strlen($desc))
		{
			if($status==1)
			{
				$status=0;
				$msg="Description cannot be blank.";
			}
		}
		else if(!is_numeric($point))
		{
			if($status==1)
			{
				$status=0;
				$msg="Points should be number.";
			}
		}
		else if(!is_numeric($amount))
		{
			if($status==1)
			{
				$status=0;
				$msg="Amount should be number.";
			}
		}
	
	if($status)
	{
	$sql="insert into PackageDetails values(DEFAULT,'".$title."','".$desc."','upload/".$_FILES["file"]["name"]."','".$point."','".$amount."',NOW(),'".$isactive."','".$type."','".$_FILES["file"]["name"]."','".$pkgDuration."')";
	
	$result=mysql_query($sql);

	if($result){
		
	}
	else{
		$result=0;
		$msg= "".mysql_error();
	}
	}
	mysql_close($conn);
     
   }
}
else
  {
	if($status==1)
	{
		$status=0;
		$msg=$msg101;
	}
}

if($status)
{
	echo '{"responsestatus":"1", "msg": "Updated successfully."}';
	
	//header("location: SocialShare.php");
	
}
else{
	echo '{"responsestatus":"2", "msg": "'.$msg.'"}';
	
	//header("location: SocialShare.php");
}

?>