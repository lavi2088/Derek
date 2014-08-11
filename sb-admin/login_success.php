<?
session_start();
if(!session_is_registered(myusername)){
header("location:index.php");
}

$host="mysql13.000webhost.com"; // Host name
$username="a1056688_dbforum"; // Mysql username
$password="lavi2088"; // Mysql password
$db_name="a1056688_dbforum"; // Database name
$tbl_name="tb_docDetail"; // Table name

// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");
$sql="SELECT * FROM $tbl_name ";
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
function showDoc(doc)
{
//alert(doc);

window.location="http://lavi2088.site11.com/admin/ViewDocument.php?docId="+doc;
//window.location = "http://www.google.com";
}
</script>
</head>
<body >

<div id="wrapper" align='center'>
<h1 align='center'>Admin Portal</h1>
<hr />
<hr/>
<table border=1 align='center' style="width:1000px; table-layout:fixed">
<thead><tr><th width=10%>Title</th><th width=27%>Document Description</th><th width=10%>Document Name</th><th width=3%>Mode</th><th width=10%>Path</th><th width=20%>Full Path</th><th width=10%>Date</th><th width=5%>No</th></tr></thead>
<tbody>
<?php
$count=0;
$colorCode=0;
while($row = mysql_fetch_array($result))
{

echo "<tr ><td style='font-size:18px; color:#00000;  display:none '>";
  echo  $cat_name = $row['DocId'];
echo "</td>";
echo "<td style='font-size:18px; color:#00000;   width:10%; '>";
  echo  $cat_name = $row['DocTitle'];
echo "</td>";
echo "<td  style='font-size:18px; color:#00000; width:27%; '>";
  echo  "<div style='height:50px; width:100%; overflow:hidden;'>".$cat_name = $row['DocDesc']."</div>";
echo "</td>";
echo "<td  style='font-size:18px; color:#00000; width:10%; '>";
  echo  $cat_name = $row['DocName'];
echo "</td>";
echo "<td  style='font-size:18px; color:#00000; width:3%; '>";
  echo  $cat_name = $row['DocMode'];
echo "</td>";
echo "<td  style='font-size:18px; color:#00000; width:10%; '>";
  echo  $cat_name = $row['DocPath'];
echo "</td>";
echo "<td  style='font-size:18px; color:#00000; width:20%; '>";
  echo  $cat_name = $row['DocFullModePath'];
echo "</td>";
echo "<td  style='font-size:18px; color:#00000; width:10%;  '>";
  echo  $cat_name = $row['AddDate'];
echo "</td>";
echo "<td  style='font-size:18px; color:#00000; width:5%; '>";
  echo  $cat_name = $row['DocSequenceNo'];
echo "</td>";

echo "<td  style='font-size:18px; color:#00000; width:5%; '>";
$temVal=$row['DocId'];
 // echo  "<input type='button' value='View' onclick='showDoc($temVal)'/>";
  echo "<a href='javascript:showDoc($temVal);'>View</a>";
echo "</td></tr>";

$count++;
}
?>
 </tbody>
</table> 
<br />



<div class="footer">
<br />
<p align=center style="color:#ffffff;">Copyright © 1997-2013 Reader App, All Rights Reserved </p>
</div>
</div>
</body>
</html>
			