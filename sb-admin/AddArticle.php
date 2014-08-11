<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
   <HEAD>
      <TITLE>Article Page</TITLE>
<link rel="stylesheet" type="text/css" href="css/style.css" media="screen" />
<script src="http://code.jquery.com/jquery-1.10.0.min.js"></script>
   </HEAD>
   <BODY>
<div class="wrapper" >
<!-- Header -->
<div class="header"> </div>

<!--End Header -->

<!-- Container-->
<div class="container"> 

<table width=800 height=400 >
<form enctype="multipart/form-data" action="uploadArticle.php" method="post">
<tr>
<td width=30%>Title</td><td width=70%><input type="text" placeholder="Title" name="title"></td>
</tr>

<tr>
<td width=30%>Description</td><td width=70%><input type="text" placeholder="Description" name="title"></td>
</tr>

<tr>
<td width=30%>Status</td><td width=70%>
<select name='status'>
  <option value="yes">YES</option>
  <option value="no">NO</option>
</select></td>
</tr>

<tr>
<td width=30%>Add Photo</td>
<td width=70%>  <input type="hidden" name="MAX_FILE_SIZE" value="1000000" />
    Choose a file to upload: <input name="uploaded_file" type="file" /></td>
</tr>
 
</table>
<input type="submit" value="SUBMIT" />
</form>

</div>
</div>
</body> 
</html>