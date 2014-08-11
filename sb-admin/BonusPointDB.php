<?php
include 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="sharepagedetail"; // Table name

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
//echo "get userid".$_POST['userid'];
$userid=$_POST['userid'];
$notierror101="Point should be number.";
$status=1;
$errormsg="";

if(!is_numeric($_POST['point'])){
	$status=0;
	$errormsg=$notierror101;
}

if($status)
{
$sqlStmt="SELECT * FROM userdetail WHERE userid='".$userid."'";
$result1=mysql_query($sqlStmt);
$existingVal=0;
$tokenid='';
$notificationMsg='';
$userResultData= mysql_fetch_row($result1);
$tokenid=$userResultData[14];

$redeemPoints=$_POST['point'];
//echo $redeemPoints."rrrr";
$totalPoints=getBonusAccountPointsData($userid);
//echo $totalPoints."tttttt";
$totalPoints=$totalPoints+$redeemPoints;
//echo $totalPoints."ffffff";
$sqlUpdate="";

$sqlUpdate="update userdetail set totalpoint=".$totalPoints." where userid='".$userid."'";
//echo $sqlUpdate;
$result=mysql_query($sqlUpdate);

$sqlUpdateMessage="insert into tbl_message VALUES (DEFAULT,'".$userid."','You have been rewarded with ".$_POST['point']." points','You have been rewarded with ".$_POST['point']." points','M',DEFAULT,0,0,0,DEFAULT,1)";
//echo $sqlUpdateMessage;
$resultBouns=mysql_query($sqlUpdateMessage);

mysql_close($conn);
$notificationMsg='You have been rewarded with '.$_POST['point'].' points';
//echo $tokenid;
//echo $notificationMsg;
//header("Location: apns/simplepush.php?tokenid=".$tokenid."&msg=".$notificationMsg."&type=b");


//************************Push notification service **********************

// Put your device token here (without spaces):
//$deviceToken = '134d46da59ce4528a905103ed5fec722d0ca1adfc5b8a44a712cb1aa3bc85b76';
$deviceToken = $tokenid;
//echo "Device token: ".$deviceToken;
// Put your private key's passphrase here:
$passphrase = 'Derek2469';

// Put your alert message here:
$message=rawurldecode( $notificationMsg );
$messgae=stripslashes($message);

////////////////////////////////////////////////////////////////////////////////

$ctx = stream_context_create();
stream_context_set_option($ctx, 'ssl', 'local_cert', 'apns/'.$certname);
stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);

// Open a connection to the APNS server
$fp = stream_socket_client(
	'ssl://gateway.sandbox.push.apple.com:2195', $err,
	$errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

if (!$fp)
	exit("Failed to connect: $err $errstr" . PHP_EOL);

//echo 'Connected to APNS' . PHP_EOL;

// Create the payload body
$body['aps'] = array(
	'alert' => $message,
	'sound' => 'default'
	);
$body['aps'] = array('alert' => $message, 'badge' => 1, 'sound' => 'default');
// Encode the payload as JSON
$payload = json_encode($body);

// Build the binary notification
$msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;

// Send it to the server
$result = fwrite($fp, $msg, strlen($msg));
/*
if (!$result)
	echo 'Message not delivered' . PHP_EOL;
else
	echo 'Message successfully delivered' . PHP_EOL; */

// Close the connection to the server
fclose($fp);

if($_GET['type']=='b')
{
	//header('Location: ../UserList.php');
}
}

if($status)
{
	echo '{"responsestatus":"1", "msg": "Updated successfully."}';
	
}
else{
	echo '{"responsestatus":"2", "msg": "'.$errormsg.'"}';
}
?>	