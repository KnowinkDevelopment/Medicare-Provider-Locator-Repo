<?php
	
	//get passed variables
	$userName = $_POST['UserName'];
	$userCity = $_POST['UserCity'];
	$userState = $_POST['UserState'];
	$userStateAbbrev = $_POST['UserStateAbbrev'];
	$userEmail = $_POST['UserEmail'];
	
	$servername = "ramjamlaxcom1.ipagemysql.com";
	$username = "mpl_admin";
	$password = "mpl_admin";
	$dbname = "mpl_main";

	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbname);

	// Check connection
	if ($conn->connect_error) {
		echo "Connection failed!";
    	die("Connection failed: " . $conn->connect_error);
	} else { 
		
	$sql = "INSERT INTO accounts (UserName, UserCity, UserState, UserStateAbbrev, UserEmail, UserPass) VALUES ('$userName', '$userCity', '$userState', '$userStateAbbrev', '$userEmail')";
		
	if ($conn->query($sql) === TRUE) {
		echo "Success";
	} else {
		echo "Fail: " . $sql . "::" . $conn->error;
	}
				
	
?>