<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'student1', 'Abc12345', "aic");

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
				
		$idofficer = $_GET['idofficer'];
		$nameofficer = $_GET['nameofficer'];
		$iduser = $_GET['iduser'];
		$nameuser = $_GET['nameuser'];
		$title = $_GET['title'];
		$todo = $_GET['todo'];
		
							
		$sql = "INSERT INTO `job`(`id`, `idofficer`, `nameofficer`, `iduser`, `nameuser`, `title`, `todo`, `status`) VALUES (Null,'$idofficer','$nameofficer','$iduser','$nameuser','$title','$todo','assign')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>