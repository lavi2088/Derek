<?php 

    // if the code parameter has been sent, we retrieve the access_token

    if($_GET['code']) {

        $code = $_GET['code'];

       // echo $code;

        $url = "https://api.instagram.com/oauth/access_token";

        $access_token_parameters = array(

                'client_id'                =>     'dc5f7bdb48fc4356922bdca6d5429960',

                'client_secret'            =>     '287ce88a837f4483a0adfb8d47220e29',

                'grant_type'               =>     'authorization_code',

                'redirect_uri'             =>     'http://lavi2088.site11.com/mobile/instagram/redirect.php',

                'code'                     =>     $code

        );

       // we retrieve the access_token and user's data

        $curl = curl_init($url);

        curl_setopt($curl,CURLOPT_POST,true);

        curl_setopt($curl,CURLOPT_POSTFIELDS,$access_token_parameters);

        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);

        $result = curl_exec($curl);

        curl_close($curl);



        $arr = json_decode($result,true);



        $pictureURL = 'https://api.instagram.com/v1/users/'.$arr['user']['id'].'/media/recent?access_token='.$arr['access_token'];



        // to get the user's photos

        $curl = curl_init($pictureURL);

        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);

        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);

        $pictures = curl_exec($curl);

        curl_close($curl);



        $pics = json_decode($pictures,true);



        // display the url of the last image in standard resolution

       // echo $pics['data'][0]['images']['standard_resolution']['url'];


     //echo $pictures;
    }
else{
echo "error";
}



?>

<html>
<head>

</head>
<body>
<br />

<br />

<br />

<h1 style="color:#666666">Please wait...</h1>
</body>
</html>