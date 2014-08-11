<?php
include 'dbconfig.php';
// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
$id=$_POST['id'];
$title=$_POST['title'];
$desc=$_POST['desc'];
$point=$_POST['points'];
$amount=$_POST['amount'];
$isactive=$_POST['isactive'];
$type=$_POST['type'];
$pkgDuration=$_POST['pkgDuration'];

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

      move_uploaded_file($_FILES["file"]["tmp_name"],
      "upload/" . $_FILES["file"]["name"]);
      echo "Stored in: " . "upload/" . $_FILES["file"]["name"];

	$sql="UPDATE PackageDetails SET pkgTitle='".$title."',pkgDescription='".$desc."',pkgImagePath='upload/".$_FILES["file"]["name"]."', pkgPoints='".$point."', pkgAmount='".$amount."',AddedDate=NOW(), isActive='".$isactive."', pkgType='".$type."', imgname='".$_FILES["file"]["name"]."', pkgduration='".$pkgDuration."' where pkgId='".$id."'";
	echo $sql;
	$result=mysql_query($sql);

	if($result){
		echo "success";
			header('location: AddNewPackage.php');
	}
	else{
		echo "".mysql_error();
	}

		mysql_close($conn);
     
   }
}
else
  {
  echo "Invalid file";
  header("location: EditPackage.php?id=".$id."&error=1&msg=Invalid Image.");
  }

?>