<?php
$notificationmsg=$_REQUEST['msg'];
$message=rawurldecode( $notificationmsg );
$notificationmsg=stripslashes($message);
$notfiication101="Message cannot be blank.";
//echo $notificationmsg;
$status=1;
$msg="";
if(!strlen($message))
{
	$status=0;
	$msg=$notfiication101;
}
else{
	//header("location: apns/NotifyAllUser_Service.php?msg=".$notificationmsg);
}

if($status)
{
	echo '{"responsestatus":"1", "msg": "Notification sent successfully."}';
	header("location: apns/NotifyAllUser_Service.php?msg=".$notificationmsg);
	
}
else{
	echo '{"responsestatus":"2", "msg": "'.$msg.'"}';
}

?>