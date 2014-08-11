<?php
function str_replace_once($str_pattern, $str_replacement, $string){

    if (strpos($string, $str_pattern) !== false){
        $occurrence = strpos($string, $str_pattern);
        return substr_replace($string, $str_replacement, strpos($string, $str_pattern), strlen($str_pattern));
    }

    return $string;
}

session_start();
include_once 'dbconfig.php';
include 'GlobalFunction.php';
$tbl_name="PackageDetails"; // Table name

if(!isset($_SESSION['username'])){
header("Location: ../admin/index.html");
}
// Connect to server and select databse.
mysql_connect("$host", "$username", "$password")or die("cannot connect");
mysql_select_db("$db_name")or die("cannot select DB");

$sqlJournal="SELECT * FROM tbl_journal ORDER BY title ASC";
$resultJournal=mysql_query($sqlJournal);

$sqlSymptoms="SELECT * FROM tbl_symptoms ORDER BY title ASC";
$resultSymptoms=mysql_query($sqlSymptoms);

?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Weed Beacon - Journal</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">

    <!-- Add custom CSS here -->
    <link href="css/sb-admin.css" rel="stylesheet">
    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
	<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
	<script type="text/javascript">
	$(function() {
	$('.error').hide();
	$('.invaliderror').hide();
		$("#submitBtn").click(function() {
			
	$('.error').hide();
    var name = $("input#title").val();
      if (name == "") {
      $("label#title_error").show();
      $("input#title").focus();
	  console.log("in title");
      return false;
    }
      var type = $("input#type").val();
      if (type == "") {
      $("label#type_error").show();
      $("input#type").focus();
	  console.log("in type");
      return false;
    }
	
	var suggestion = $("input#suggestion").val();
      if (suggestion == "") {
      $("label#suggestion_error").show();
      $("input#suggestion").focus();
	  console.log("in suggestion");
      return false;
    }
	
	var latitude = $("input#latitude").val();
      if (latitude == "") {
      $("label#latitude_error").show();
      $("input#latitude").focus();
	  console.log("in latitude");
      return false;
    }
	
	var longitude = $("input#longitude").val();
      if (suggestion == "") {
      $("label#longitude_error").show();
      $("input#longitude").focus();
	  console.log("in longitude");
      return false;
    }
	
	var jtype = $("#jtype").val();
      if (jtype == "Select") {
      $("label#jtype_error").show();
      $("input#jtype").focus();
	  console.log("in jtype");
      return false;
    }
	
	var stype = $("#stype").val();
      if (stype == "Select") {
      $("label#stype_error").show();
      $("input#stype").focus();
	  console.log("in stype");
      return false;
    }
    
    var address = $("input#address").val();
      if (address == "") {
      $("label#address_error").show();
      $("input#address").focus();
	  console.log("in address");
      return false;
    }
	
	var keywords = $("input#keywords").val();
      if (keywords == "") {
      $("label#keywords_error").show();
      $("input#keywords").focus();
	  console.log("in keywords");
      return false;
    }
	
	var studydata = $("input#studydata").val();
      if (studydata == "") {
      $("label#studydata_error").show();
      $("input#studydata").focus();
	  console.log("in studydata");
      return false;
    }
	
	var link = $("input#link").val();
      if (link == "") {
      $("label#link_error").show();
      $("input#link").focus();
	  console.log("in link");
      return false;
    }
    
    var link = $("input#zipcode").val();
      if (link == "") {
      $("label#zipcode_error").show();
      $("input#zipcode").focus();
	  console.log("in zipcode");
      return false;
    }
	
	console.log("after validation");
	$.ajax({
           type: "POST",
           url: "dbclass/cannabisdb.php",
           data: $(".form-signin").serialize(), //Serialize a form to a query string.
           success: function(response){
               console.log("response"+response); //response from server.
			   if(response=="success"){
			   console.log("js success");
			   $('.invaliderror').hide();
				window.location.href="cannabis.php";
			   }
			   else{
			   console.log("js error");
					$('.invaliderror').show();
			   }
           }
         });
	console.log("after sub");
	return false;
	});
	
	});
	
	
	</script>
  </head>
  
  <body>

    <div id="wrapper">

      <!-- Sidebar -->
      <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="index.html">Weed Beacon Admin</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
          <ul class="nav navbar-nav side-nav">
            <li ><a href="home.php"><i class="fa fa-dashboard"></i> Journals</a></li>
            <li><a href="symptoms.php"><i class="fa fa-bar-chart-o"></i> Symptoms</a></li>
            <li class="active"><a href="cannabis.php"><i class="fa fa-table"></i> Cannabis</a></li>
			<li ><a href="deals.php"><i class="fa fa-edit"></i> Deals</a></li>
			<li ><a href="addnews.php"><i class="fa fa-edit"></i> News</a></li>
            <!--<li ><a href="symptoms.php"><i class="fa fa-edit"></i> Symptoms</a></li>
            <li><a href="typography.html"><i class="fa fa-font"></i> Typography</a></li>
            <li><a href="bootstrap-elements.html"><i class="fa fa-desktop"></i> Bootstrap Elements</a></li>
            <li><a href="bootstrap-grid.html"><i class="fa fa-wrench"></i> Bootstrap Grid</a></li>
            <li><a href="blank-page.html"><i class="fa fa-file"></i> Blank Page</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-caret-square-o-down"></i> Dropdown <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="#">Dropdown Item</a></li>
                <li><a href="#">Another Item</a></li>
                <li><a href="#">Third Item</a></li>
                <li><a href="#">Last Item</a></li>
              </ul>
            </li> -->
          </ul>

		</div><!-- /.navbar-collapse -->
      </nav>

      <div id="page-wrapper">

        <div class="row">
          <div class="col-lg-12">
            <h1>Cannabis <small>Add Data</small></h1>
            <ol class="breadcrumb">
              <li><a href="index.html"><i class="fa fa-dashboard"></i> Dashboard</a></li>
              <li class="active"><i class="fa fa-edit"></i> Cannabis</li>
            </ol>
            
          </div>
        </div><!-- /.row -->

        <div class="row">
          <div class="col-lg-6">

            <form role="form" method="post" class="form-signin">

              <div class="form-group">
                <label>Cannabis Title</label>
                <input class="form-control" name="title" id="title" placeholder="Enter text" >
				<label class="error" for="username" id="title_error">This field is required.</label>
              </div>

              <div class="form-group">
                <label>Cannabis type</label>
                <input class="form-control" placeholder="Enter text" name="type" id="type">
				<label class="error" for="username" id="type_error">This field is required.</label>
              </div>
			  
			  <div class="form-group">
                <label>Cannabis suggestions</label>
                <input class="form-control" placeholder="Enter text" name="suggestion" id="suggestion">
				<label class="error" for="username" id="suggestion_error">This field is required.</label>
              </div>
			  
			  <div class="form-group"> 
                <label>Latitude</label>
                <input class="form-control" placeholder="Enter text" name="latitude" id="latitude">
				<label class="error" for="username" id="latitude_error">This field is required.</label>
				<label><a href="https://www.google.co.in/maps/" target="_blank">Find latitude</a></label> 
              </div>
			  
			  <div class="form-group">
                <label>Longitude</label>
                <input class="form-control" placeholder="Enter text" name="longitude" id="longitude">
				<label class="error" for="username" id="longitude_error">This field is required.</label>
				<label><a href="https://www.google.co.in/maps/" target="_blank">Find longitude</a></label>
              </div>
			  
			<div class="form-group">
                <label>Rating</label>
                <select class="form-control" id="rating" name="rating">
				<option>5</option>
				<option>4</option>
				<option>3</option>
				<option>2</option>
				<option>1</option>
				<select>
				<label class="error" for="username" id="jtype_error">This field is required.</label>
              </div>
              
          </div>
          <div class="col-lg-6">
			
              
			<div class="form-group">
                <label>Journal Type</label>
                <select class="form-control" id="jtype" name="jtype">
				<option>Select</option>
				<?php
				while($tableName = mysql_fetch_row($resultJournal)) {
					echo "<option>".$tableName[1]."</option>";
				}
				?>
				<select>
				<label class="error" for="username" id="jtype_error">This field is required.</label>
              </div>
			  
			<div class="form-group">
                <label>Symptoms Type</label>
                <select class="form-control" id="stype" name="stype">
				<option>Select</option>
				<?php
				while($tableName = mysql_fetch_row($resultSymptoms)) {
					echo "<option>".$tableName[1]."</option>";
				}
				?>
				<select>
				<label class="error" for="username" id="stype_error">This field is required.</label>
              </div>
              
			 <div class="form-group">
                <label>Address</label>
                <input class="form-control" placeholder="Enter Address" name="address" id="address">
				<label class="error" for="username" id="address_error">This field is required.</label>
            </div>
             
			<div class="form-group">
                <label>Keywords</label>
                <input class="form-control" placeholder="Enter text" name="keywords" id="keywords">
				<label class="error" for="username" id="keywords_error">This field is required.</label>
            </div>
			  
            <div class="form-group">
                <label>FDA Study Data</label>
                <textarea class="form-control" rows="3" name="studydata" id="studydata" ></textarea>
				<label class="error" for="username" id="studydata_error">This field is required.</label>
              </div>
			  
			  <div class="form-group">
                <label>PDF Link</label>
                <input class="form-control" placeholder="Enter link" name="link" id="link">
				<label class="error" for="username" id="link_error">This field is required.</label>
              </div>
              
              <div class="form-group">
                <label>Zipcode</label>
                <input class="form-control" placeholder="Enter zipcode" name="zipcode" id="zipcode">
				<label class="error" for="username" id="zipcode_error">This field is required.</label>
              </div>
			  
            <button type="submit" class="btn btn-success" id="submitBtn">Submit</button>
			<label class="invaliderror"  id="invalid_error">Technical error occurred.</label>
			</form>
          </div>
        </div><!-- /.row -->

      </div><!-- /#page-wrapper -->

    </div><!-- /#wrapper -->

    <!-- JavaScript -->
    <script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.js"></script>

  </body>
</html>