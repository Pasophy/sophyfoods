<?php

	include 'conn.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;   
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {				
		$name = $_GET['name'];
		$username = $_GET['username'];
		$password = $_GET['password'];
		$usertype = $_GET['usertype'];
		
							
		$sql = "INSERT INTO `tbuser`(`id`, `name`, `username`, `password`,`usertype`) VALUES (Null,'$name','$username','$password','$usertype')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo " wellcome sophy";
   
}
	mysqli_close($link);
?>