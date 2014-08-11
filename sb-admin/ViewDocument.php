<?
session_start();
if(!session_is_registered(myusername)){
header("location:index.php");
}

include 'dbconfig.php';
$tbl_name="tb_docDetail"; // Table name

// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
$sql="SELECT * FROM $tbl_name where DocId= '".$_GET[docId]."'";
//echo $sql;
$result=mysql_query($sql);
$count=mysql_num_rows($result);
//echo $count;
?>

<html>
<head>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.css" />
<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
<script src="http://code.jquery.com/mobile/1.2.0/jquery.mobile-1.2.0.min.js"></script>
<style>
body{
padding:0;
margin:0 auto;
}
#wrapper{
width:1024px;
height:auto;
background-color:#F5F5F5;
margin:0px auto;
}

table td{
    word-wrap:break-word; 
    min-height:50px; 
    height:50px;
}

.footer{
    width:100%;
    height:100px;
background-color:#666666;

}

</style>
<script type="text/javascript">
var editFlag=0;
$(document).ready(function() {

//$("#txt1").enable(false);
$("#txt1").attr('disabled','disabled'); 
$("#txt2").attr('disabled','disabled'); 
$("#txt3").attr('disabled','disabled'); 
$("#txt4").attr('disabled','disabled'); 
$("#txt5").attr('disabled','disabled'); 
$("#txt6").attr('disabled','disabled'); 
$("#txt7").attr('disabled','disabled'); 
$("#docDesc").attr('disabled','disabled'); 
$("#docFullFile").attr('disabled','disabled');
$("#docHalfFile").attr('disabled','disabled');
//alert('ready');

});

function checkform(){
if(editFlag){
alert('t');
return true;
}
else{
alert('f');
return false;
}

}

function editBtnClick(){

//alert("edit");
editFlag=1;
$("#txt1").removeAttr('disabled');
$("#txt2").removeAttr('disabled');
$("#txt3").removeAttr('disabled');
$("#txt4").removeAttr('disabled');
$("#txt5").removeAttr('disabled');
$("#txt6").removeAttr('disabled');
$("#txt7").removeAttr('disabled');
$("#docDesc").removeAttr('disabled');
$("#docFullFile").removeAttr('disabled');
$("#docHalfFile").removeAttr('disabled');
}
</script>
</head>
<body >

<div id="wrapper" align='center'>
<h1 align='center'>Admin Portal</h1>
<hr />
<hr/>

<form action="UpdateFile.php" onSubmit="return checkform()">
<table border=0 align='center' style="width:1000px; table-layout:fixed">

<tbody>
<?php
$count=0;
$colorCode=0;
while($row = mysql_fetch_array($result))
{

echo "<tr >";
echo "<td>Title:</td><td style='font-size:18px; color:#00000;   width:70%; '>";
  echo  "<input type='text' id='txt1' value='".$cat_name = $row['DocTitle']."' width=300 />";
echo "</td></tr>";
echo "<tr><td>Document Description :</td><td  style='font-size:18px; color:#00000; width:27%; '>";
  echo  "<textarea id='docDesc' rows=10 cols=70 >".$cat_name = $row['DocDesc']."</textarea>";

echo "</td></tr>";
echo "<tr><td>Document Name :</td><td  style='font-size:18px; color:#00000; width:10%; '>";

echo  "<input type='text'  id='txt2' value='".$cat_name = $row['DocName']."' width=250px />";
echo "</td></tr>";
echo "<tr><td>Mode :</td><td  style='font-size:18px; color:#00000; width:3%; '>";
 
echo  "<input type='text' id='txt3' value='".$cat_name = $row['DocMode']."' width=250px />";
echo "</td></tr>";
echo "<tr><td>Document Path :</td><td  style='font-size:18px; color:#00000; width:10%; '>";
  
echo  "<input type='text' id='txt4' value='".$cat_name = $row['DocPath']."' width=250px /><input type='file' id='docHalfFile' data-inline='true'/>";
echo "</td></tr>";
echo "<tr><td>Dcoument Path(Full Mode) :</td><td  style='font-size:18px; color:#00000; width:20%; '>";

echo  "<input type='text' id='txt5' value='".$cat_name = $row['DocFullModePath']."' width=250px data-inline='true'/><input type='file' id='docFullFile' data-inline='true'/>";
echo "</td></tr>";
echo "<tr><td>Date :</td><td  style='font-size:18px; color:#00000; width:10%;  '>";
 
echo  "<input type='text' id='txt6' value='".$cat_name = $row['AddDate']."' width=250px />";
echo "</td></tr>";
echo "<tr><td>Document Sequence:</td><td  style='font-size:18px; color:#00000; width:5%; '>";

echo  "<input type='text'  id='txt7' value='".$cat_name = $row['DocSequenceNo']."' width=250px />";
echo "</td></tr>";





$count++;
}
?>
 </tbody>
</table> 
<br />

<a href="javascript:editBtnClick();" data-role="button"  data-inline="true" data-theme="e" style="width:100px;">Edit</a><input type="submit" value="Done" data-role="button"  data-inline="true" style="width:100px;"><a href="javascript:window.history.back();" data-role="button" data-inline="true" data-theme="b" style="width:100px;">Cancel</a> 

<div class="footer">
<br />
<p align=center style="color:#ffffff;">Copyright © 1997-2013 Reader App, All Rights Reserved </p>
</div>
</div>
</body>
</html>
			