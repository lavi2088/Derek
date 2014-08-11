<?php
include 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="sharepagedetail"; // Table name

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
echo "get userid".$_POST['userid'];
$userid=$_POST['userid'];
$message=$_POST['message'];
$message=rawurldecode( $_POST['message'] );
$notificationMsg=$message;
$sqlStmtUser="SELECT * FROM userdetail WHERE userid='$userid'";
$resultUser=mysql_query($sqlStmtUser);
$userResultDataUser= mysql_fetch_row($resultUser);
$tokenid='';
$tokenid=$userResultDataUser[14];

//Message box handling
if($_POST['msgType']=="bonus"){

$sqlUpdateMessage="insert into tbl_message VALUES (DEFAULT,'".$userid."','".$_POST['message']."','".$_POST['desc']."','B',DEFAULT,0,0,0,DEFAULT,1)";
echo $sqlUpdateMessage;
$resultMessage=mysql_query($sqlUpdateMessage);

}
else{
$sqlUpdateVoucher="select * from PackageDetails where pkgId='".$_POST['voucheroption']."'";
echo $sqlUpdateVoucher;
$resultVoucher=mysql_query($sqlUpdateVoucher);
$voucherdetails=mysql_fetch_row($resultVoucher);

$sqlUpdateMessageVoucher="insert into tbl_message VALUES (DEFAULT,'".$userid."','".$_POST['message']."','".$_POST['desc']."','V',DEFAULT,".$_POST['voucheroption'].",".$voucherdetails[5].",".$voucherdetails[4].",DEFAULT,1)";
echo $sqlUpdateMessageVoucher;
$resultMessageVoucher=mysql_query($sqlUpdateMessageVoucher);

}

//*****End of message box handling

$notificationMsg=stripslashes($notificationMsg);
$message=rawurldecode( $_POST['message'] );

if($resultUser){
echo "success";
header("Location: apns/notifyuser_service.php?tokenid=".$tokenid."&msg=".$notificationMsg."");

}
else{
echo "".mysql_error();
}
mysql_close($conn);

?>	