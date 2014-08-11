<?php
include 'dbconfig.php';
$tbl_name="sharepagedetail"; // Table name

//Messgae
$voucherMsg="Please select any voucher from dropdown.";
$pointMsg="Point should be number.";

// Connect to server and select databse.
$conn=mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
$value1='';
$value2='';
$value3='';
$value4='';
$value5='';
$value6='';
$value7='';
$value8='';
$responseStatusFlag=1;
$resMsg="";
//Validation
if($_POST['SPoint1']=='V'){
	if($_POST['voucheroption1'] === "select")
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 1 :".$voucherMsg;
		}
	}
	
}
else if($_POST['SPoint1']=='S'){
	//$value1='0';
}
else{
	$value1=$_POST['Point1'];
	
	if(!is_numeric($_POST['Point1']))
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 1 :".$pointMsg;
		}
	}
}

if($_POST['SPoint2']=='V'){
	if($_POST['voucheroption2'] === "select")
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 2 :".$voucherMsg;
		}
	}
	
}
else if($_POST['SPoint2']=='S'){
	//$value1='0';
}
else{
	$value1=$_POST['Point2'];
	
	if(!is_numeric($_POST['Point2']))
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 2 :".$pointMsg;
		}
	}
}

if($_POST['SPoint3']=='V'){
	if($_POST['voucheroption3'] === "select")
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 3 :".$voucherMsg;
		}
	}
	
}
else if($_POST['SPoint3']=='S'){
	//$value1='0';
}
else{
	$value1=$_POST['Point3'];
	
	if(!is_numeric($_POST['Point3']))
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 3 :".$pointMsg;
		}
	}
}

if($_POST['SPoint4']=='V'){
	if($_POST['voucheroption4'] === "select")
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 4 :".$voucherMsg;
		}
	}
	
}
else if($_POST['SPoint4']=='S'){
	//$value1='0';
}
else{
	$value1=$_POST['Point4'];
	
	if(!is_numeric($_POST['Point4']))
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 4 :".$pointMsg;
		}
	}
}

if($_POST['SPoint5']=='V'){
	if($_POST['voucheroption5'] === "select")
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 5 :".$voucherMsg;
		}
	}
	
}
else if($_POST['SPoint5']=='S'){
	//$value1='0';
}
else{
	$value1=$_POST['Point5'];
	
	if(!is_numeric($_POST['Point5']))
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 5 :".$pointMsg;
		}
	}
}

if($_POST['SPoint6']=='V'){
	if($_POST['voucheroption6'] === "select")
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 6 :".$voucherMsg;
		}
	}
	
}
else if($_POST['SPoint6']=='S'){
	//$value1='0';
}
else{
	$value1=$_POST['Point6'];
	
	if(!is_numeric($_POST['Point6']))
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 6 :".$pointMsg;
		}
	}
}

if($_POST['SPoint7']=='V'){
	if($_POST['voucheroption7'] === "select")
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 7 :".$voucherMsg;
		}
	}
	
}
else if($_POST['SPoint7']=='S'){
	//$value1='0';
}
else{
	$value1=$_POST['Point7'];
	
	if(!is_numeric($_POST['Point7']))
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 7 :".$pointMsg;
		}
	}
}

if($_POST['SPoint8']=='V'){
	if($_POST['voucheroption8'] === "select")
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 8 :".$voucherMsg;
		}
	}
	
}
else if($_POST['SPoint8']=='S'){
	//$value1='0';
}
else{
	$value1=$_POST['Point8'];
	
	if(!is_numeric($_POST['Point8']))
	{
		if($responseStatusFlag==1)
		{
			$responseStatusFlag=0;
			$resMsg="Point 8 :".$pointMsg;
		}
	}
}

//End of validation

if($responseStatusFlag)
{
if($_POST['SPoint1']=='V'){
	$value1=$_POST['voucheroption1']."V";
}
else if($_POST['SPoint1']=='S'){
	$value1='0';
}
else{
	$value1=$_POST['Point1'];
}

if($_POST['SPoint2']=='V'){
	$value2=$_POST['voucheroption2']."V";
}
else if($_POST['SPoint2']=='S'){
	$value2='0';
}
else{
	$value2=$_POST['Point2'];
}

if($_POST['SPoint3']=='V'){
	$value3=$_POST['voucheroption3']."V";
}
else if($_POST['SPoint3']=='S'){
	$value3='0';
}
else{
	$value3=$_POST['Point3'];
}

if($_POST['SPoint4']=='V'){
	$value4=$_POST['voucheroption4']."V";
}
else if($_POST['SPoint4']=='S'){
	$value4='0';
}
else{
	$value4=$_POST['Point4'];
}
if($_POST['SPoint5']=='V'){
	$value5=$_POST['voucheroption5']."V";
}
else if($_POST['SPoint5']=='S'){
	$value5='0';
}
else{
	$value5=$_POST['Point5'];
}
if($_POST['SPoint6']=='V'){
	$value6=$_POST['voucheroption6']."V";
}
else if($_POST['SPoint6']=='S'){
	$value6='0';
}
else{
	$value6=$_POST['Point6'];
}

if($_POST['SPoint7']=='V'){
	$value7=$_POST['voucheroption7']."V";
}
else if($_POST['SPoint7']=='S'){
	$value7='0';
}
else{
	$value7=$_POST['Point7'];
}

if($_POST['SPoint8']=='V'){
	$value8=$_POST['voucheroption8']."V";
}
else if($_POST['SPoint8']=='S'){
	$value8='0';
}
else{
	$value8=$_POST['Point8'];
}

$sql="update SpinWheelSettingTable set col1='".$value1."', col2='".$value2."', col3='".$value3."', col4='".$value4."', col5='".$value5."', col6='".$value6."', col7='".$value7."', col8='".$value8."'";
//echo $sql;
$result=mysql_query($sql);

//echo '{"responsestatus":"1", "msg": "Updated successfully."}';

if($result){

echo '{"responsestatus":"1", "msg": "Updated successfully."}';
//header("location:SpinSetting.php");
}
else{
//echo "".mysql_error();
echo '{"responsestatus":"2", "msg": "'.mysql_error().'"}';
}
}else{
echo '{"responsestatus":"2", "msg": "'.$resMsg.'"}';
}
mysql_close($conn);

?>