<?php
include 'GlobalFunction.php';
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Password Recovery</title></head>
<script type="text/javascript" >
function loadCall(){
var status=''+<?php echo $_GET['status'] ?>;
	if(status==1){
		alert("Password reset successfully");
		window.location.href="http://st-hubert.com";
	}
}

loadCall();
</script>
<body>
<h1  align="center" cellpadding="0" cellspacing="1" ><? echo $appName; ?></h1>
<form name="form1" method="post" action="UpdateNewPassword.php" enctype="multipart/form-data" onsubmit="return validateForm()">
<input type="hidden" name="userid" value="<?php echo $_GET['email'];?>" >
<table width="300" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
<tr>

<td>
<table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
<tr>
<td colspan="3"><strong>Reset Password </strong></td>
</tr>
<tr>
<td width="78">New Password</td>
<td width="6">:</td>
<td width="294"><input name="password1" type="password" id="password1"></td>
</tr>
<tr>
<td>Re Password</td>
<td>:</td>
<td><input name="mypassword" type="password" id="mypassword"></td>
</tr>
<tr>
<td>&nbsp;</td>
<td>&nbsp;</td>
<td><input type="submit" name="Submit" value="SUBMIT"></td>
</tr>
</table>
</td>
</form>
</tr>
</table>

 <script type="text/javascript">
 function validateForm()
{
//alert('validate');
	if(document.getElementById('password1').value.length>=6 && document.getElementById('mypassword').value.length>=6)
	{
		if(document.getElementById('password1').value===document.getElementById('mypassword').value){
			return true;
		}
		else{
			alert('Invalid password');
			return false;
		}
	}
	else{
		alert('Invalid password length');
		return false;
	}
}
 </script>
 
</body></html>