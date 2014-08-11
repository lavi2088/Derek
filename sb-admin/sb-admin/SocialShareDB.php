<?php
include 'dbconfig.php';
// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

//******Error msg ****/

$msg100="Technical error occured, please contact to admin.";
$msg101="Please use image of type jpeg, jpg, png and image size should not exceed 2 MB.";
$msg102="Image name should not contain spaces .";
$msg103="Please use image of type jpeg, jpg, png.";
$msg104="Please use image of type jpeg, jpg, png.";

$category=$_REQUEST["category"];

//echo $category;

$status=1;
$msg="";

if(isset($_GET['socialId']))
{
	$id=$_GET['socialId'];
}
//Image File process
if($category=="coupon" || $category=="picture" || $category=="blog")
{
$allowedExts = array("jpeg", "jpg", "png");
$temp = explode(".", $_FILES["file"]["name"]);
$extension = end($temp);
if ((($_FILES["file"]["type"] == "image/jpeg")
|| ($_FILES["file"]["type"] == "image/jpg")
|| ($_FILES["file"]["type"] == "image/pjpeg")
|| ($_FILES["file"]["type"] == "image/x-png")
|| ($_FILES["file"]["type"] == "image/png"))
&& ($_FILES["file"]["size"] < 1024*512*4)
&& in_array($extension, $allowedExts))
{
  if ($_FILES["file"]["error"] > 0)
    {
    //echo "Return Code: " . $_FILES["file"]["error"] . "<br>";
    
    	if($status==1)
		{
			$status=0;
			$msg=$msg101;
		}
    }
  else
    {
    /*
    echo "Upload: " . $_FILES["file"]["name"] . "<br>";
    echo "Type: " . $_FILES["file"]["type"] . "<br>";
    echo "Size: " . ($_FILES["file"]["size"] / 1024) . " kB<br>";
    echo "Temp file: " . $_FILES["file"]["tmp_name"] . "<br>"; 
    */
	if (count(explode(' ', $username)) > 1) {
  		// some white spaces are there.
  		
  		if($status==1)
		{
			$status=0;
			$msg=$msg102;
		}
	}
	else{
		move_uploaded_file($_FILES["file"]["tmp_name"],
      	"socialshareupload/" . $_FILES["file"]["name"]);
      }
      
    }
}
else{
	if($status==1)
	{
		$status=0;
		$msg=" ".$_FILES["file"]["type"]." ".$msg101;
	}	
}

}     
//End of image file process

//Image File process
if($category=="coupon")
{
$allowedExts = array("jpeg", "jpg", "png");
$temp = explode(".", $_FILES["logofile"]["name"]);
$extension = end($temp);
if ((($_FILES["logofile"]["type"] == "image/jpeg")
|| ($_FILES["logofile"]["type"] == "image/jpg")
|| ($_FILES["logofile"]["type"] == "image/pjpeg")
|| ($_FILES["logofile"]["type"] == "image/x-png")
|| ($_FILES["logofile"]["type"] == "image/png"))
&& ($_FILES["logofile"]["size"] < 1024*512*4)
&& in_array($extension, $allowedExts))
{
  if ($_FILES["logofile"]["error"] > 0)
    {
    //echo "Return Code: " . $_FILES["logofile"]["error"] . "<br>";
    	
    	if($status==1)
		{
			$status=0;
			$msg=$msg101;
		}
    }
  else
    {
    /*
    echo "Upload: " . $_FILES["logofile"]["name"] . "<br>";
    echo "Type: " . $_FILES["logofile"]["type"] . "<br>";
    echo "Size: " . ($_FILES["logofile"]["size"] / 1024) . " kB<br>";
    echo "Temp file: " . $_FILES["logofile"]["tmp_name"] . "<br>";
    */
	
	if (count(explode(' ', $username)) > 1) {
  		
  		if($status==1)
		{
			$status=0;
			$msg=$msg102;
		}
	}
	else{
		move_uploaded_file($_FILES["logofile"]["tmp_name"],
      		"socialshareupload/" . $_FILES["logofile"]["name"]);
      }
    }
}
else{
	if($status==1)
	{
		$status=0;
		$msg="Coupon2".$msg101;
	}	
}
}     
//End of image file process

switch ($category) {
    case 'coupon':
    	//echo $category;
        $title=$_REQUEST["title"];
        $desc=$_REQUEST["desc"];
        $savingper=$_REQUEST["savingper"];
        $pointval=$_REQUEST["pointval"];
        $tags=$_REQUEST["tags"];
        $colorcode=$_REQUEST["colorcode"];
        $expiredays=$_REQUEST["expiredays"];
        $amount=$_REQUEST["amountval"];
        $expireddate = date("Y-m-d H:i:s", time() + $expiredays*24*60*60);
        
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
		else if(!is_numeric($savingper))
		{
			if($status==1)
			{
				$status=0;
				$msg="Saving percentage should be number.";
			}
		}
		else if(!is_numeric($pointval))
		{
			if($status==1)
			{
				$status=0;
				$msg="Point should be number.";
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
		
		if($status==1)
		{
        	$sqlStmt="insert into tbl_socialpost values(DEFAULT,'".$title."','".$desc."','socialshareupload/".$_FILES["file"]["name"]."',DEFAULT,
         '','".$_FILES["file"]["name"]."',1,".$pointval.",0,'',".$savingper.",'".$tags."','".$amount."','social','coupon','','".$colorcode."'
         , '', '', '".$expireddate."','".$_FILES["logofile"]["name"]."', 'socialshareupload/".$_FILES["logofile"]["name"]."')";
         
        	if(isset($_GET['socialid']))
			{
				$id=$_GET['socialid'];
				$sqlStmt="update tbl_socialpost set title='".$title."', description='".$desc."', imgpath='socialshareupload/".$_FILES["file"]["name"]."', imgname='".$_FILES["file"]["name"]."',
			pointvalue='".$pointval."', savingper='".$savingper."', tags='".$tags."', addeddate=DEFAULT, colorcode='".$colorcode."'
			, expiredate='".$expireddate."', amount='".$amount."',logoimagename='".$_FILES["logofile"]["name"]."', logoimagepath='socialshareupload/".$_FILES["logofile"]["name"]."'  where id='".$id."'";
			}

        	$result=mysql_query($sqlStmt);
        }
        
        break;
        
    case 'picture':
        $title=$_REQUEST["title"];
        $desc=$_REQUEST["desc"];
        $link=$_REQUEST["link"];
        $pointval=$_REQUEST["pointval"];
        $tags=$_REQUEST["tags"];
        
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
		else if (!preg_match('/http:/',$link))
		{
			if($status==1)
			{
				$status=0;
				$msg="Please enter complete URL with http:// .";
			}
		}
		else if(!is_numeric($pointval))
		{
			if($status==1)
			{
				$status=0;
				$msg="Point should be number.";
			}
		}
		
		if($status==1)
		{
		
        $sqlStmt="insert into tbl_socialpost values(DEFAULT,'".$title."','".$desc."','socialshareupload/".$_FILES["file"]["name"]."',DEFAULT,
         '".$link."','".$_FILES["file"]["name"]."',1,".$pointval.",0,'',0,'".$tags."',0,'social','picture','', '', '', '', '', '', '')";
		 
		 if(isset($_GET['socialid']))
		{
			$id=$_GET['socialid'];
			$sqlStmt="update tbl_socialpost set title='".$title."', description='".$desc."', imgpath='socialshareupload/".$_FILES["file"]["name"]."', imgname='".$_FILES["file"]["name"]."',
			pointvalue='".$pointval."', link='".$link."', tags='".$tags."', addeddate=DEFAULT where id='".$id."'";
		}
		
        $result=mysql_query($sqlStmt);
        }

        break;
        
    case 'blog':
        $title=$_REQUEST["title"];
        $desc=$_REQUEST["desc"];
        $link=$_REQUEST["link"];
        $pointval=$_REQUEST["pointval"];
        $tags=$_REQUEST["tags"];
        $writername=$_REQUEST["writername"];
        
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
		else if (!preg_match('/http:/',$link))
		{
			if($status==1)
			{
				$status=0;
				$msg="Please enter complete URL with http:// .";
			}
		}
		else if(!is_numeric($pointval))
		{
			if($status==1)
			{
				$status=0;
				$msg="Point should be number.";
			}
		}
		
		if($status==1)
		{
        	$sqlStmt="insert into tbl_socialpost values(DEFAULT,'".$title."','".$desc."','socialshareupload/".$_FILES["file"]["name"]."',DEFAULT,
         '".$link."','".$_FILES["file"]["name"]."',1,".$pointval.",0,'',0,'".$tags."',0,'social','blog','', '', '', '".$writername."', '', '', '')";
		 
		 	 if(isset($_GET['socialid']))
			{
				$id=$_GET['socialid'];
				$sqlStmt="update tbl_socialpost set title='".$title."', description='".$desc."', imgpath='socialshareupload/".$_FILES["file"]["name"]."', imgname='".$_FILES["file"]["name"]."',
			pointvalue='".$pointval."', link='".$link."', tags='".$tags."', addeddate=DEFAULT, writername='".$writername."' where id='".$id."'";
			}
		
        	$result=mysql_query($sqlStmt);
        }
        
        break;
        
    case 'text':
        //echo "Text";
        break;
        
    case 'video':
       	$title=$_REQUEST["title"];
        $link=$_REQUEST["link"];
        $pointval=$_REQUEST["pointval"];
        $tags=$_REQUEST["tags"];
        
        if(!strlen($title))
		{
			if($status==1)
			{
				$status=0;
				$msg="Title cannot be blank.";
			}
		}
		else if (!preg_match('/http/',$link))
		{
			if($status==1)
			{
				$status=0;
				$msg="Please enter complete URL with http:// or https://.";
			}
		}
		else if(!is_numeric($pointval))
		{
			if($status==1)
			{
				$status=0;
				$msg="Point should be number.";
			}
		}
		
		if($status==1)
		{
        $sqlStmt="insert into tbl_socialpost values(DEFAULT,'".$title."','','', DEFAULT,
         '".$link."','',1,".$pointval.",0,'',0,'".$tags."',0,'social','video','', '', '', '', '', '', '')";
		 
		if(isset($_GET['socialid']))
		{
			$id=$_GET['socialid'];
			$sqlStmt="update tbl_socialpost set title='".$title."', pointvalue='".$pointval."', link='".$link."', tags='".$tags."', addeddate=DEFAULT where id='".$id."'";
		}
		
        $result=mysql_query($sqlStmt);
        }
        
        break;
        
    case 'podcast':
        $title=$_REQUEST["title"];
        $link=$_REQUEST["link"];
        $pointval=$_REQUEST["pointval"];
        $tags=$_REQUEST["tags"];
        
        if(!strlen($title))
		{
			if($status==1)
			{
				$status=0;
				$msg="Title cannot be blank.";
			}
		}
		else if (!preg_match('/http:/',$link))
		{
			if($status==1)
			{
				$status=0;
				$msg="Please enter complete URL with http:// .";
			}
		}
		else if(!is_numeric($pointval))
		{
			if($status==1)
			{
				$status=0;
				$msg="Point should be number.";
			}
		}
		
		if($status==1)
		{
        $sqlStmt="insert into tbl_socialpost values(DEFAULT,'".$title."','','',DEFAULT,
         '".$link."','',1,".$pointval.",0,'',0,'".$tags."',0,'social','podcast','', '', '', '', '', '', '')";
		 
		   if(isset($_GET['socialid']))
		{
			$id=$_GET['socialid'];
			$sqlStmt="update tbl_socialpost set title='".$title."', pointvalue='".$pointval."', link='".$link."', tags='".$tags."', addeddate=DEFAULT where id='".$id."'";
		}
		
        $result=mysql_query($sqlStmt);
        }
        
        break;
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