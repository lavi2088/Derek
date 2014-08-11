<?php
$adminLoginPath="http://mymobipoints.com/admin/";
$certname="ck_zencig_dev.pem";
function str_replace_once($str_pattern, $str_replacement, $string){

    if (strpos($string, $str_pattern) !== false){
        $occurrence = strpos($string, $str_pattern);
        return substr_replace($string, $str_replacement, strpos($string, $str_pattern), strlen($str_pattern));
    }

    return $string;
}

function getTotalNoOfUsers(){
$sql="SELECT * FROM userdetail";
$result=mysql_query($sql);
$count=mysql_num_rows($result);
return $count;
}

function getTotalOrderedPackage(){
$sql="SELECT * FROM MonthlyPackageUsers";
$result=mysql_query($sql);
$count=mysql_num_rows($result);
return $count;
}

function getTotalShareDetails(){
$sql="SELECT * FROM sharepagedetail";
$result=mysql_query($sql);

$count=mysql_num_rows($result);
return $count;
}

function getTotalPointsEarned(){
$sql="SELECT SUM(bonuspoint) FROM sharepagedetail where status='Y'";
$result=mysql_query($sql);
$userResultData= mysql_fetch_row($result);
return $userResultData[0];
}

function getTotalRedeemed(){
$returnData=0;
$sql="SELECT SUM(pointredeemed) FROM MonthlyPackageUsers";
$result=mysql_query($sql);
$userResultData= mysql_fetch_row($result);
$returnData=$userResultData[0];
return $returnData;
}

function getFacebookGraphData(){
$visit=10;
$monthNumber=date('m');
$yearNumber=date('Y'); 
for($i=1;$i<=12;$i++)
{
$monthIndex=$i;
if($monthIndex<10){
$monthIndex='0'.$monthIndex;
}
$fromDate=$yearNumber.'-'.$monthIndex.'-01';
$toDate=$yearNumber.'-'.$monthIndex.'-31';
$sql="SELECT COUNT(username) FROM sharepagedetail where socialtype='F' AND date_format(date, '%Y-%m-%d')>='".$fromDate."' AND date_format(date, '%Y-%m-%d')<='".$toDate."'";
$result=mysql_query($sql);
$userResultData= mysql_fetch_row($result);
$facebook_data[] = '['.$i.','.$userResultData[0].']';
}		
$facebook_data = '['.implode(',',$facebook_data).']';
return $facebook_data;
}

function getTwitterGraphData(){
$visit=10;
$monthNumber=date('m');
$yearNumber=date('Y'); 
for($i=1;$i<=12;$i++)
{
$monthIndex=$i;
if($monthIndex<10){
$monthIndex='0'.$monthIndex;
}
$fromDate=$yearNumber.'-'.$monthIndex.'-01';
$toDate=$yearNumber.'-'.$monthIndex.'-31';
$sql="SELECT COUNT(username) FROM sharepagedetail where socialtype='T' AND date_format(date, '%Y-%m-%d')>='".$fromDate."' AND date_format(date, '%Y-%m-%d')<='".$toDate."'";
$result=mysql_query($sql);
$userResultData= mysql_fetch_row($result);
$facebook_data[] = '['.$i.','.$userResultData[0].']';
}		
$facebook_data = '['.implode(',',$facebook_data).']';
return $facebook_data;
}

function getInstagramGraphData(){
$visit=10;
$monthNumber=date('m');
$yearNumber=date('Y'); 
for($i=1;$i<=12;$i++)
{
$monthIndex=$i;
if($monthIndex<10){
$monthIndex='0'.$monthIndex;
}
$fromDate=$yearNumber.'-'.$monthIndex.'-01';
$toDate=$yearNumber.'-'.$monthIndex.'-31';
$sql="SELECT COUNT(username) FROM sharepagedetail where socialtype='I' AND date_format(date, '%Y-%m-%d')>='".$fromDate."' AND date_format(date, '%Y-%m-%d')<='".$toDate."'";
$result=mysql_query($sql);
$userResultData= mysql_fetch_row($result);
$facebook_data[] = '['.$i.','.$userResultData[0].']';
}		
$facebook_data = '['.implode(',',$facebook_data).']';
return $facebook_data;
}

function getFoursquareGraphData(){
$visit=10;
$monthNumber=date('m');
$yearNumber=date('Y'); 
for($i=1;$i<=12;$i++)
{
$monthIndex=$i;
if($monthIndex<10){ 
$monthIndex='0'.$monthIndex;
}
$fromDate=$yearNumber.'-'.$monthIndex.'-01';
$toDate=$yearNumber.'-'.$monthIndex.'-31';
$sql="SELECT COUNT(username) FROM sharepagedetail where socialtype='FR' AND date_format(date, '%Y-%m-%d')>='".$fromDate."' AND date_format(date, '%Y-%m-%d')<='".$toDate."'";
$result=mysql_query($sql);
$userResultData= mysql_fetch_row($result);
$facebook_data[] = '['.$i.','.$userResultData[0].']';
}		
$facebook_data = '['.implode(',',$facebook_data).']';
return $facebook_data;
}

function getTotalRedeemedData($userid){
$sql="SELECT SUM(point) FROM activitylog where social_type='AAA' AND user_name='".$userid."'";
$result=mysql_query($sql);
$userResultData= mysql_fetch_row($result);

if(!$userResultData[0])
{
$totalPointRedeemed=0;
}
else{
$totalPointRedeemed=$userResultData[0];
}
return $totalPointRedeemed;
}

function getTotalAccountPointsData($userid){
$totalPoints=0;
$sql="select fbpoint, twpoint, istpoint, fourpoint, spinpoint, totalpoint from userdetail where userid='".$userid."'";
$result=mysql_query($sql);
$userResultData= mysql_fetch_row($result);
$totalPoints=$userResultData[0] + $userResultData[1] + $userResultData[2] + $userResultData[3] + $userResultData[4]+ $userResultData[5];
return $totalPoints;
}

function getSpinAccountPointsData($userid){
$totalPoints=0;
$sql="select fbpoint, twpoint, istpoint, fourpoint, spinpoint from userdetail where userid='".$userid."'";
$result=mysql_query($sql);
$userResultData= mysql_fetch_row($result);
$totalPoints=$userResultData[4];
return $totalPoints;
}

function getBonusAccountPointsData($userid){
$totalPoints=0;
$sql="select totalpoint from userdetail where userid='".$userid."'";
$result=mysql_query($sql);
$userResultData= mysql_fetch_row($result);
$totalPoints=$userResultData[0];
return $totalPoints;
}

function getSocialSharePointWeight($socialType){

$sql="select * from SocialPointsDetails";
$result=mysql_query($sql);
$userResultData= mysql_fetch_row($result);

if($socialType=='F')
{
	return $userResultData[0];
}
else if($socialType=='T')
{
	return $userResultData[1];
}
else if($socialType=='I')
{
	return $userResultData[2];
}
else if($socialType=='FR')
{
	return $userResultData[3];
}

}

function random_numbers($digits) {
    $min = pow(10, $digits - 1);
    $max = pow(10, $digits) - 1;
    return mt_rand($min, $max);
}

?>