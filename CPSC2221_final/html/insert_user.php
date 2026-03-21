<?php
$servername = "localhost";
$username   = "root";
$password   = "";
$database   = "tictactoe";
 
// Getting values
$UserID   = $_POST['UserID'];
$Username = $_POST['Username'];
$Email    = $_POST['Email'];
$Password = $_POST['Password'];
 
// Input validation
if (empty($UserID) || empty($Username) || empty($Email) || empty($Password)) {
	echo "Error: All fields are required. <br>";
	echo "<a class='btn btn-secondary mt-2' href='signUp.html'>Go Back</a>";
	exit;
}
 
// Create connection
$conn = new mysqli($servername, $username, $password, $database);
 
// Check connection
if ($conn->connect_error) {
	die("Connection failed: " . $conn->connect_error);
} else {
	echo "<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'>";
	echo "<div class='container mt-4'>";
	echo "Connection Successful! <br>";
}
 
// Construct the query
$query = "INSERT INTO GameUser VALUES('$UserID', '$Username', '$Email', '$Password')";
 
// Execute the query
if ($conn->query($query) === TRUE) {
    $_SESSION['UserID']   = $UserID;
    $_SESSION['Username'] = $Username;

    // redirect
    if($_SESSION['role'] === "player"){
        header("Location: player.html");
        exit();
    } else if($_SESSION['role'] === "manager"){
        header("Location: manager.html");
        exit();
    }
} else {
	echo "Error: " . $conn->error;
}

$conn->close();

