<?php
session_start();
 
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
 
// Make sure role was set from index.html
if (empty($_SESSION['role'])) {
	echo "Error: Role not set. Please go back and select a role. <br>";
	echo "<a class='btn btn-secondary mt-2' href='index.html'>Go Back</a>";
	exit;
}
 
// Create connection
$conn = new mysqli($servername, $username, $password, $database);
 
// Check connection
if ($conn->connect_error) {
	die("Connection failed: " . $conn->connect_error);
}
 
// Construct the query
$query = "INSERT INTO GameUser VALUES('$UserID', '$Username', '$Email', '$Password')";
 
// Execute the query
if ($conn->query($query) === TRUE) {
	$_SESSION['UserID']   = $UserID;
	$_SESSION['Username'] = $Username;
	// Role is already in session from checkRole.php
 
	// Insert into Player or TournamentManager based on role
	if ($_SESSION['role'] === "player") {
		if ($conn->query("INSERT INTO Player VALUES('$UserID', 0, 0, 0, 0)") !== TRUE) {
			echo "Error creating player profile: " . $conn->error;
			exit;
		}
		$conn->close();
		header("Location: player.php");
		exit();
	} else if ($_SESSION['role'] === "manager") {
		if ($conn->query("INSERT INTO TournamentManager VALUES('$UserID', 0)") !== TRUE) {
			echo "Error creating manager profile: " . $conn->error;
			exit;
		}
		$conn->close();
		header("Location: manager.php");
		exit();
	}
} else {
	echo "<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'>";
	echo "<div class='container mt-4'>";
	echo "<div class='alert alert-danger'>Error: " . $conn->error . "</div>";
	echo "<a class='btn btn-secondary' href='signUp.html'>Go Back</a></div>";
}
 
$conn->close();
?>
