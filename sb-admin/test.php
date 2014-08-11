<?php
include_once 'dbconfig.php';
// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$visit=10;
$monthNumber=date('m');
$yearNumber=date('Y');


echo "data"; 
for($i=1;$i<=12;$i++)
{
$monthIndex=$i;
if($monthIndex<10){
$monthIndex='0'.$monthIndex;
}
$fromDate=$yearNumber.'-'.$monthIndex.'-01';
$toDate=$yearNumber.'-'.$monthIndex.'-31';
echo $fromDate;
$sql="SELECT COUNT(username) FROM sharepagedetail where socialtype='FR' AND date_format(date, '%Y-%m-%d')>='".$fromDate."' AND date_format(date, '%Y-%m-%d')<='".$toDate."'";
echo "\n".$sql;
$result=mysql_query($sql);
$userResultData= mysql_fetch_row($result);
$facebook_data[] = '['.$i.','.$userResultData[0].']';
}		
$facebook_data = '['.implode(',',$facebook_data).']';
echo $facebook_data;

?>
