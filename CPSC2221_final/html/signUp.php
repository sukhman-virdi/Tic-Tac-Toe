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
$Role     = $_POST['Role'];
 
// Input validation
if (empty($UserID) || empty($Username) || empty($Email) || empty($Password) || empty($Role)) {
	echo "Error: All fields are required. <br>";
	echo "<a class='btn btn-secondary mt-2' href='signUp.html'>Go Back</a>";
	exit;
}

if (!in_array($Role, ['player', 'manager'])) {
	echo "<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'>";
	echo "<div class='container mt-4'>";
	echo "<div class='alert alert-danger'>Error: Invalid role selected.</div>";
	echo "<a class='btn btn-secondary' href='signUp.html'>Go Back</a></div>";
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
	$_SESSION['role'] = $Role;

    // redirect
    if ($_SESSION['role'] === "player") {
        if ($conn->query("INSERT INTO Player VALUES('$UserID', 0, 0, 0, 0)") !== TRUE) {
            echo "Error creating player profile: " . $conn->error;
            exit;
        }
        header("Location: player.html");
        exit();
    } else if ($_SESSION['role'] === "manager") {
        if ($conn->query("INSERT INTO TournamentManager VALUES('$UserID', 0)") !== TRUE) {
            echo "Error creating manager profile: " . $conn->error;
            exit;
        }
        header("Location: manager.html");
        exit();
    }
} else {
	echo "Error: " . $conn->error;
}

$conn->close();
