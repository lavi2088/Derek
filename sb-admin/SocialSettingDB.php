<?php
include 'dbconfig.php';
// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
$title=$_POST['title'];
$desc=$_POST['desc'];
$link=$_POST['link'];

$allowedExts = array("jpeg", "jpg", "png");
$temp = explode(".", $_FILES["file"]["name"]);
$extension = end($temp);
if ((($_FILES["file"]["type"] == "image/jpeg")
|| ($_FILES["file"]["type"] == "image/jpg")
|| ($_FILES["file"]["type"] == "image/pjpeg")
|| ($_FILES["file"]["type"] == "image/x-png")
|| ($_FILES["file"]["type"] == "image/png"))
&& ($_FILES["file"]["size"] < 1024*512)
&& in_array($extension, $allowedExts))
  {
  if ($_FILES["file"]["error"] > 0)
    {
    echo "Return Code: " . $_FILES["file"]["error"] . "<br>";
    }
  else
    {
    echo "Upload: " . $_FILES["file"]["name"] . "<br>";
    echo "Type: " . $_FILES["file"]["type"] . "<br>";
    echo "Size: " . ($_FILES["file"]["size"] / 1024) . " kB<br>";
    echo "Temp file: " . $_FILES["file"]["tmp_name"] . "<br>";

    if (file_exists("upload/" . $_FILES["file"]["name"]))
      {
      echo $_FILES["file"]["name"] . " already exists. ";
	  header("location: SocialSetting.php?error=1&msg=Image already exists.");
      }
    else
      {
      move_uploaded_file($_FILES["file"]["tmp_name"],
      "upload/" . $_FILES["file"]["name"]);
      echo "Stored in: " . "upload/" . $_FILES["file"]["name"];

	$sql="insert into SocialShareDetails values(DEFAULT,'".$title."','".$desc."','upload/".$_FILES["file"]["name"]."',DEFAULT,'".$link."','".$_FILES["file"]["name"]."','1')";
	echo $sql;
	$result=mysql_query($sql);

	if($result){
		echo "success";
		header("location: SocialSetting.php");
	}
	else{
		echo "".mysql_error();
	}

		mysql_close($conn);
     }
   }
}
else
  {
  echo "Invalid file";
  }

?>