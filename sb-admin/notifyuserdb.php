<?php
include 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="sharepagedetail"; // Table name

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
//echo "get userid".$_POST['userid'];
$userid=$_POST['userid'];
$message=$_POST['message'];
$message=rawurldecode( $_POST['message'] );
$notificationMsg=$message;
$sqlStmtUser="SELECT * FROM userdetail WHERE userid='$userid'";
$resultUser=mysql_query($sqlStmtUser);
$userResultDataUser= mysql_fetch_row($resultUser);
$tokenid='';
$tokenid=$userResultDataUser[14];

//***********************Validation*****************************
$notfiication101="Message title cannot be blank.";
$notfiication102="Message description cannot be blank.";
$notfiication103="Please select any voucher from drop down list.";
$notfiication104="Bonus point should be number.";

$status=1;
$errormsg="";
if(!strlen($message))
{
	$status=0;
	$errormsg=$notfiication101;
}
else if(!strlen($_POST['desc']))
{
	if($status==1)
	{
		$status=0;
		$errormsg=$notfiication102;
	}
}
else if(!is_numeric($savingper)){
	if($_POST['msgType']=="bonus")
	{
		if(!is_numeric($_POST['bonuspoint']))
		{
			$status=0;
			$errormsg=$notfiication104;
		}
	}
	else{
		if($status==1)
		{
			if(!is_numeric($_POST['voucheroption']))
			{
				$status=0;
				$errormsg=$notfiication103;
			}
		}
	}
}

if($status)
{
//Message box handling
if($_POST['msgType']=="bonus"){

$sqlUpdateMessage="insert into tbl_message VALUES (DEFAULT,'".$userid."','".$_POST['message']."','".$_POST['desc']."','B',DEFAULT,0,0,0,DEFAULT,1)";
//echo $sqlUpdateMessage;
$resultMessage=mysql_query($sqlUpdateMessage);

}
else{
$sqlUpdateVoucher="select * from PackageDetails where pkgId='".$_POST['voucheroption']."'";
//echo $sqlUpdateVoucher;
$resultVoucher=mysql_query($sqlUpdateVoucher);
$voucherdetails=mysql_fetch_row($resultVoucher);

$sqlUpdateMessageVoucher="insert into tbl_message VALUES (DEFAULT,'".$userid."','".$_POST['message']."','".$_POST['desc']."','V',DEFAULT,".$_POST['voucheroption'].",".$voucherdetails[5].",".$voucherdetails[4].",DEFAULT,1)";
//echo $sqlUpdateMessageVoucher;
$resultMessageVoucher=mysql_query($sqlUpdateMessageVoucher);

}

//*****End of message box handling

$notificationMsg=stripslashes($notificationMsg);
//$message=rawurldecode( $_POST['message'] );

if($resultUser){

}
else{
//echo "".mysql_error();
}
mysql_close($conn);

//**************************Push Notification***********************************

// Put your device token here (without spaces):
//$deviceToken = '0f888535fc4c1ba2a36c919eac827f6bcf0c8e3e5e7d7fd8fa24fbb59266e682';
$deviceToken = $tokenid;

// Put your private key's passphrase here:
$passphrase = 'Derek2469';

// Put your alert message here:
$message=rawurldecode( $notificationMsg );
$messgae=stripslashes($message);
$message=rawurldecode( $messgae );
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
}	

if($status)
{
	echo '{"responsestatus":"1", "msg": "Notification sent successfully."}';	
}
else{
	echo '{"responsestatus":"2", "msg": "'.$errormsg.'"}';
}

?>	