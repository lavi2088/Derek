<?php
session_start();
include 'dbconfig.php';
$tbl_name="sharepagedetail"; // Table name

if(!isset($_SESSION['myusername'])){
header("Location: ../index.php");
}
// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$sql="SELECT * FROM $tbl_name WHERE status='N'";
$result=mysql_query($sql);
?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="1000">
<title>TanningLoft Active Users</title>
<link href="css/homestyle.css" rel="stylesheet" type="text/css">
<link href="css/menu_styles.css" rel="stylesheet" type="text/css">
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

<div id="container">
    <div id="left"><!--Start of left -->
	<div id="logoDiv" >
	<img src="menu_assets/images/dashboardLogo.png" style="margin-left:35px; margin-top:15px;"/>
	<h3 style="color:#8c8c8c; padding-left:15px;">Dashboard</h3>
	</div>
<div id='cssmenu'>
<ul>
   <li class='sc'><a href='../PostHomePage.php' ><span>Posts</span><img src="menu_assets/images/postIcon.png" alt="post" style="float:right; margin-right:10px" /></a></li>
   <li><a href='../ActiveUsers.php' class="mark"><span>Active Users</span><img src="menu_assets/images/activeUserIcon.png" alt="post" style="float:right; margin-right:10px" /></a></li>
   <li><a href='#'><span>SpinWheel settings</span><img src="menu_assets/images/SpinWheelIcon.png" alt="post" style="float:right; margin-right:10px" /></a></li>
   <li><a href='#'><span>Hot Links</span><img src="menu_assets/images/hotLinkIcon.png" alt="post" style="float:right; margin-right:10px" /></a></li>
   <li><a href='#'><span>Social Posts</span><img src="menu_assets/images/SocialPostIcon.png" alt="post" style="float:right; margin-right:10px" /></a></li>
	<li><a href='#'><span>Point Request</span><img src="menu_assets/images/PointRequestIcon.png" alt="post" style="float:right; margin-right:10px" /></a></li>
	<li><a href='#'><span>Banned Users</span><img src="menu_assets/images/BannedIcon.png" alt="post" style="float:right; margin-right:10px" /></a></li>
	<li><a href='#'><span>Tools</span><img src="menu_assets/images/toolsicon.png" alt="post" style="float:right; margin-right:10px" /></a></li>
	<li><a href='#'><span>Settings</span><img src="menu_assets/images/settingicon.png" alt="post" style="float:right; margin-right:10px" /></a></li>
</ul>
</div>

 </div><!--End of left -->
    <div id="right">
      <div class="topBar" >
	  <a href="#"><img src="menu_assets/images/addBtn.png" alt="add" style="margin:15px;"/></a>
	  
	  <ul id="topMenu">
	  <li><img src="menu_assets/images/cloudBtn.png" alt="add" /></li>
	  <li><img src="menu_assets/images/SocialPostIcon.png" alt="add" /></li>
	  <li><img src="menu_assets/images/bellIcon.png" alt="add" /></li>
	  
	  </ul>
	  </div>
	  <div style="width:300px; height:30px; margin-left:30px;">
	  <table><tr>
	  <td><img src="image/activeUserIconBlue.png" /></td><td><h2 style="color:#3f8bea">&nbsp;&nbsp;&nbsp;&nbsp;Add New Package</h2></td></tr>
	  </table>
	  </div>
	  
	  <!--Post Container Div -->
	  <div class="postDiv">
<br />
	  <h2 style="margin:10px">Add New Package Control Panel</h2>

<div style="width:700px; height: 380px;">  
<table width=700px class="postTable" border=0>
<tr>
    <th align="left" width=30% colspan="1" scope="col" style="padding:10px;">User</th>
    <th align="center" width=20% colspan="2" scope="col" style="padding-top:10px; padding-bottom:10px;">Points Pending</th>
    <th align="left" width=20% colspan="1" scope="col" style="padding-top:10px; padding-bottom:10px;">Link</th>
    <th align="left" width=30% colspan="2" scope="col" style="padding-top:10px; padding-bottom:10px;">Action</th>
  </tr>

<?php
$counter=0;
$colorCode="";
while($tableName = mysql_fetch_row($result)) {

if($counter%2==0){
$colorCode="#f7f7f7";
}
else{
$colorCode="#ffffff";
}
$counter++;
$shareDesc="";
$shareImgName="";
if($tableName[2]=="F")
{
$shareDesc="see on Facebook";
$shareImgName="image/fb_icon.png";
}
else if($tableName[2]=="T"){
$shareDesc="see on Twitter";
$shareImgName="image/tw_icon.png";
}
else if($tableName[2]=="I"){
$shareDesc="see on Instagram";
$shareImgName="image/ista_icon.png";
}
else if($tableName[2]=="FR"){
$shareDesc="see on Foursquare";
$shareImgName="image/square_icon.png";
}

echo '<tr style="background-color:'.$colorCode.'"><td width=30% style="padding-left:10px;">'.$tableName[1].'</td><td width=10% align="right">'.$tableName[4].'&nbsp;&nbsp;</td><td width=10%><img src="'.$shareImgName.'" /></td><td width=20%><a href="'.$tableName[3].'" target="_blank" >'.$shareDesc.'</a></td><td width=15%><input type="button" class="denyBtn" onclick="denyClicked(\''.$tableName[0].'\',\''.$tableName[2].'\',\''.$tableName[7].'\')" value="">&nbsp;&nbsp;deny</td><td width=15%><input type="button" value="" class="approveBtn" onclick="approveClicked(\''.$tableName[0].'\',\''.$tableName[2].'\',\''.$tableName[7].'\')">&nbsp;&nbsp;approve</td></tr>';

}

?>
</table>
</div>

<table style="margin-left:10px;">
<tr>
<td style="font-size:14px; font-family:'Arial'; color:#333333;">Powered By</td><td style="font-size:14px; font-family:'Arial'; font-weight:bold; color:#5394eb;"> Myriad Interactive Media</td><td style="font-size:14px; font-family:'Arial'; color:#333333;">, Toronto </td>
</tr>
</table>

</div>
<!--End of post contatiner div -->
<!--Footer div -->
<div id="footerDiv">

<table width=750px style="margin-left:30px; margin-top:20px; ">
<tr>
<td width=25% style="padding:10px"><img src="image/footerLogo.png"></td><td width=37% style="font-size:14px; font-family:'Arial'; font-weight:bold; color:#333333;">MingleSuite Dashboard 2013</td><td width=28% style="font-size:14px; font-family:'Arial'; color:#333333;">Howdy, John Doe </td><td width=5%><img src="image/setttingIcon.png" ></td><td width=5%><img src="image/powerIcon.png" ></td>
</tr>
</table>

</div>
<!--End of footer div -->
</div>

<div class="clear"></div>
</div>
  
</body>
</html>