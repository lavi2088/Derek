<?php
include '../dbconfig.php';
include '../GlobalFunction.php';
// Put your device token here (without spaces):
//$deviceToken = '0f888535fc4c1ba2a36c919eac827f6bcf0c8e3e5e7d7fd8fa24fbb59266e682';
// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

// Put your private key's passphrase here:
$passphrase = 'Derek2469';

// Put your alert message here:
$message=rawurldecode( $_REQUEST['msg'] );
$message=stripslashes($message);
$message=rawurldecode( $message );
//echo "Mesaage: ".$message;

$notfiication101="Message cannot be blank.";
$status=1;
$errormsg="";
if(!strlen($message))
{
	$status=0;
	$errormsg=$notfiication101;
}

////////////////////////////////////////////////////////////////////////////////
if($status)
{
$sqlStmtUser="SELECT * FROM userdetail ";
$resultUser=mysql_query($sqlStmtUser);
while($userResultDataUser= mysql_fetch_row($resultUser))
{
$deviceToken = $userResultDataUser[14];

$ctx = stream_context_create();
stream_context_set_option($ctx, 'ssl', 'local_cert', ''.$certname);
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
//$body['aps'] = json_encode($payload);

// Encode the payload as JSON
$payload = json_encode($body);

// Build the binary notification
$msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;

// Send it to the server
$result = fwrite($fp, $msg, strlen($msg));

/*if (!$result)
	echo 'Message not delivered' . PHP_EOL;
else
	echo 'Message successfully delivered' . PHP_EOL;*/

// Close the connection to the server

fclose($fp);
}
}

if($status)
{
	echo '{"responsestatus":"1", "msg": "Notification sent successfully."}';
	
}
else{
	echo '{"responsestatus":"2", "msg": "'.$errormsg.'"}';
}
//header("Location: ../NotificationCenter.php?notifyStatus=Y");
?>