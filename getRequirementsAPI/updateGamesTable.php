<?php
require_once('dbconn.php');
// load json file
$json_string = file_get_contents('https://www.game-debate.com/game/api/list');
// decode json to an array
$data = json_decode($json_string, true);

// check for json error, if none proceed else abort.
if (json_last_error() === JSON_ERROR_NONE) {
    // JSON is valid so proceed
    
    // get only gid from $data array so we can check if already in database
    $data_gid = array();
    foreach ($data as $key => $value) {
        $gid = mysqli_real_escape_string($conn, $value['g_id']);
        array_push($data_gid, $gid);
    }

    // make array with gid's that are present in database
    $in_database = array();
    $sql = "SELECT g_id FROM games";
    $result = mysqli_query($conn,$sql);
    // fill $in_database with g_id present in database
    while($row = mysqli_fetch_assoc($result)){
        array_push($in_database, $row['g_id']);
    }

    foreach ($data as $key => $value) {
        $gid = mysqli_real_escape_string($conn, $value['g_id']);
        $gtitle = mysqli_real_escape_string($conn, $value['g_title']);

        // if gid is not in database, add it
        if(!in_array($gid, $in_database)){
            //build query
            $sql = "INSERT INTO games (g_id, name) VALUES ('$gid', '$gtitle')";
            if (mysqli_query($conn, $sql)) {
                echo "New record created successfully";
            } else {
                echo "Error: " . $sql . "</br>" . mysqli_error($conn);
            }
            echo "</br>";
            echo "</br>";
        }
        // if it is in database, do nothing
    }
}
else{
    exit;
}

// close the connection
mysqli_close($conn);
?>
