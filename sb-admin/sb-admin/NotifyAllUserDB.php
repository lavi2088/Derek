<?php
$notificationmsg=$_REQUEST['msg'];
$message=rawurldecode( $notificationmsg );
$notificationmsg=stripslashes($message);

echo $notificationmsg;
header("location: apns/NotifyAllUser_Service.php?msg=".$notificationmsg);
?>