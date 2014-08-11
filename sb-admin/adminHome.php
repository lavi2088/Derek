<?php
include 'dbconfig.php';
$tbl_name="sharepagedetail"; // Table name

// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$sql="SELECT * FROM $tbl_name WHERE status='N'";
$result=mysql_query($sql);


?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="10">
<title>Home</title>
<link rel="stylesheet" type="text/css" href="css/style.css" media="screen" />
<script src="http://code.jquery.com/jquery-1.10.0.min.js"></script>

<script type="text/javascript">

$(document).ready(function() {

//alert('ready');
});

function approveClicked(id,type,postid){

//alert(type+" Approve"+id+" "+postid);
var point=0;

if(type=='F')
{
point=5;
}
else if(type=='T')
{
point=3;
}
else if(type=='I')
{
point=10;
}
else if(type=='FR')
{
point=2;
}
else if(type=='SP')
{
point=5;
}
//alert("afetr point"+point);
$.ajax({
        url: 'UpdateFile.php',
        type: 'POST',
        data: {userid:''+id,type:""+type,postid:''+postid, point:""+point},
        success: function(response){
          // alert(response);
         window.location.reload();
        },
        error: function(){
alert("Error")
            console.log(arguments);
        }
     });
}

function denyClicked(id,type,postid){

//alert(type+" Deny"+id);
$.ajax({
        url: 'updateDenyStatus.php',
        type: 'POST',
        data: {userid:''+id,type:""+type,postid:''+postid},
        success: function(response){
           //alert(response);
         window.location.reload();
        },
        error: function(){
            console.log(arguments);
        }
     });
}

</script>
</head>

<body>
<div class="wrapper" >
<!-- Header -->
<div class="header"> </div>

<!--End Header -->

<!-- Container-->
<div class="container"> 

<ul class="top_bar_list">
<li style="padding-right:80px; font-size:30px; font-weight:bold;"> Client Dashboard</li>
<li><input type="button" class="selected_btn" value="Client Dashboard" ></li>
<li><input type="button" class="normal_btn" value="Send Notification" ></li>
<li><input type="button" class="normal_btn" value="User Setting" ></li>
<li><input type="button" class="normal_btn" value="Spinwheel Setting" ></li>
</ul>

<div class="tableBar">
<label style="color:#ffffff; font-size:22px; font-weight:bold; padding:10px; margin-top:10px;">User Points Control Panel</label>
</div>

<table width=980px>
<?php
while($tableName = mysql_fetch_row($result)) {
echo '<tr><td width=20%>'.$tableName[1].'</td><td width=10%>'.$tableName[4].'</td><td width=10%>'.$tableName[2].'</td><td width=30%><a href="'.$tableName[3].'" target="_blank" >'.$tableName[3].'</a></td><td width=15%><input type="button" value="Approve" class="approveBtn" onclick="approveClicked(\''.$tableName[0].'\',\''.$tableName[2].'\',\''.$tableName[7].'\')"></td><td width=15%><input type="button" class="denyBtn" onclick="denyClicked(\''.$tableName[0].'\',\''.$tableName[2].'\',\''.$tableName[7].'\')" value="Deny"></td></tr>';
}

?>
</table>
</div>

<!--End Container-->

<!-- Container-->
<div class="footer"> </div>

<!--End footer-->

</div>
</body>

</html>		