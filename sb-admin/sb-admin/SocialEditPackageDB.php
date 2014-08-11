<?php
include 'dbconfig.php';
// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
$title=$_POST['title'];
$desc=$_POST['desc'];
$link=$_POST['link'];
$id=$_POST['id'];
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
	  header("location: SocialEditPackage.php?id=".$id."&error=1&msg=Image already exists.");
      }
    else
      {
      move_uploaded_file($_FILES["file"]["tmp_name"],
      "upload/" . $_FILES["file"]["name"]);
      echo "Stored in: " . "upload/" . $_FILES["file"]["name"];

	$sql="UPDATE SocialShareDetails SET Title='".$title."',Description='".$desc."',ImgPath='upload/".$_FILES["file"]["name"]."',AddedDate=DEFAULT,Hyperlink='".$link."',imgname='".$_FILES["file"]["name"]."' where id='".$id."'";
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
  header("location: SocialEditPackage.php?id=".$id."&error=1&msg=Invaid Image.");
  }

?>
