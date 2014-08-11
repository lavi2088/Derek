<?php

include 'dbconfig.php';
include 'GlobalFunction.php';

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$email=$_GET['email'];

$sqlStmt="SELECT * FROM userdetail WHERE userid='$email'";
$result1=mysql_query($sqlStmt);

// Mysql_num_row is counting table row

$count=mysql_num_rows($result1);

// If result matched $myusername and $mypassword, table row must be 1 row


$sqlInsert="";
$sqlUpdate="";


$six_digit_random_number = mt_rand(100000, 999999);

$sqlUpdate="Update userdetail set password='".$six_digit_random_number."' WHERE userid='".$email."'";


if($count>0){
   $result=mysql_query($sqlUpdate);
   echo '{"error":"101","responsestatus":1}';
   
      //now we want to send them an email telling them to confirm their account. 
    $to = ""; 
    $subject = ""; 
    $message=""; 
    $headers=""; 
     
    /* recipients */ 
    $to  = $email; 
     
    /* subject */ 
    $subject = $appName." Password Reset"; 
     
    /* message */ 
    $message = '<html> 
<head> 
<title>'.$appName.' Password Reset</title> 
</head> 

<body style="font-family:verdana, arial; font-size: .8em;"> 
A request has been made to reset your '.$appName.' Account password.
<br/><br/> 
To complete the request, click on the following link of this email and follow the on screen instructions.
<br/><br/> 
To reset password and add set new password, please click on the link below:<br> 
<a title="Confirm Comment"
href="http://www.mymobipoints.com/demo-app-services/setnewpassword.php?email='.$email.'&code="'.$six_digit_random_number.'>Reset Password</a> 
<br/><br/> 
Thank you and we hope you enjoy using '.$appName.'!<br/><br/> 

</body> 
</html>'; 

    /* To send HTML mail, you can set the Content-type header. */ 
    $headers  = "MIME-Version: 1.0\r\n"; 
    $headers .= "Content-type: text/html; charset=iso-8859-1\r\n"; 
     
    /* additional headers */ 
    $headers .= "From: ".$appName." <info@myriadim.com>\r\n"; 
     
    /* and now mail it */ 
    mail($to, $subject, $message, $headers); 
}
else{
   //$result=mysql_query($sqlInsert);
   echo '{"error":"101","responsestatus":2}';
}


mysql_close($conn);

?>	