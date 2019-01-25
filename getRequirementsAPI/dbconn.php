<?php
// database connection
$conn = new mysqli('localhost', 'root', 'root', 'game_requirements');
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
