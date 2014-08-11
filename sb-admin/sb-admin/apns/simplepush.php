<?php

// Put your device token here (without spaces):
//$deviceToken = '134d46da59ce4528a905103ed5fec722d0ca1adfc5b8a44a712cb1aa3bc85b76';
$deviceToken = $_GET['tokenid'];
echo "Device token: ".$deviceToken;
// Put your private key's passphrase here:
$passphrase = 'Derek2469';

// Put your alert message here:
$message=rawurldecode( $_GET['msg'] );
$messgae=stripslashes($message);

////////////////////////////////////////////////////////////////////////////////

$ctx = stream_context_create();
stream_context_set_option($ctx, 'ssl', 'local_cert', 'ck_sthubert_dev.pem');
stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);

// Open a connection to the APNS server
$fp = stream_socket_client(
	'ssl://gateway.sandbox.push.apple.com:2195', $err,
	$errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

if (!$fp)
	exit("Failed to connect: $err $errstr" . PHP_EOL);

echo 'Connected to APNS' . PHP_EOL;

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

if (!$result)
	echo 'Message not delivered' . PHP_EOL;
else
	echo 'Message successfully delivered' . PHP_EOL;

// Close the connection to the server
fclose($fp);

if($_GET['type']=='b')
{
	header('Location: ../UserList.php');
}
?>