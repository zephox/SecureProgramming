<?php
set_time_limit(0);
// inport dbconn
require_once('dbconn.php');

// make array with gid's that are present in requirements table
$known_requirements = getKnownRequirements();
// make array with all known gid's in games table
$all_game_ids = getAllGames();

foreach ($all_game_ids as $key => $value){
    $game_id = $value;
    if(!in_array($game_id, $known_requirements)){
        // add requirements that are not present
        updateDB($game_id);
    }
}

function getAllGames(){
    global $conn;
    // create array
    $all_games = array();
    // build query
    $sql = "SELECT g_id FROM games";
    $result = mysqli_query($conn,$sql);
    // fill $all_games with g_id present in games table
    while($row = mysqli_fetch_assoc($result)){
        array_push($all_games, $row['g_id']);
    }
    return $all_games;
}

function getKnownRequirements(){
    global $conn;
    // create array
    $in_database = array();
    // build query
    $sql = "SELECT g_id FROM min_requirements";
    $result = mysqli_query($conn,$sql);
    // fill $in_database with g_id present in database
    while($row = mysqli_fetch_assoc($result)){
        array_push($in_database, $row['g_id']);
    }
    return $in_database;
}

function updateDB($game_id){
    // use FILTER_VALIDATE_INT to validate the integer given.
    $min = 0;
    $max = 99999999;
    $int_validated = filter_var($game_id, FILTER_VALIDATE_INT, array("options" => array("min_range"=>$min, "max_range"=>$max)));
    // check if ctype digit and validated.
    if(ctype_digit($game_id) && $int_validated){
        $g_id = $game_id;
    }
    else{
        echo "Invalid game id parameter given, parameter must be an integer. </br>";
        echo "Parameter given: " . $game_id . " does not meet the requirements. </br>";
        exit;
    }
    // build url
    $url = "https://www.game-debate.com/games/index.php?g_id={$g_id}";

    $html = file_get_contents($url);

    // use preg_match_all() to filter the html
    // filter minimum requirements
    preg_match_all('/<div class="devDefSysReqMin">(.*?)<\/div>/s', $html, $matchesmin);
    foreach ($matchesmin[1] as $nodemin) {
        // convert ul to array
        $reqArrayMin = ul_to_array($nodemin);
    }

    // filter recommanded requirements
    preg_match_all('/<div class="devDefSysReqRec">(.*?)<\/div>/s', $html, $matchesRec);
    foreach ($matchesRec[1] as $nodeRec) {
        // convert ul to array
        $reqArrayRec = ul_to_array($nodeRec);
    }

    $min = getCleanRequirements($reqArrayMin, $g_id);
    $rec = getCleanRequirements($reqArrayRec, $g_id);

    insertRequirements($min, 'min_requirements');
    insertRequirements($rec, 'rec_requirements');
}

function insertRequirements($array, $table){
    global $conn;
    
    // get variables
    $gid = mysqli_real_escape_string($conn, $array['g_id']);
    $cpu_intel = mysqli_real_escape_string($conn, $array['cpu_intel']);
    $cpu_amd = mysqli_real_escape_string($conn, $array['cpu_amd']);
    $memory = mysqli_real_escape_string($conn, $array['memory']);
    $gpu_nvidia = mysqli_real_escape_string($conn, $array['gpu_nvidia']);
    $gpu_amd = mysqli_real_escape_string($conn, $array['gpu_amd']);
    // build query
    $sql = "INSERT INTO $table (g_id, cpu_intel, cpu_amd, memory, gpu_nvidia, gpu_amd) 
            VALUES ('$gid', '$cpu_intel', '$cpu_amd', '$memory', '$gpu_nvidia', '$gpu_amd')";
    if (mysqli_query($conn, $sql)) {
        echo "New " . $table . " record created successfully";
        echo "</br>";
    } else {
        echo "Error: " . $sql . "</br>" . mysqli_error($conn) . " -> In table: " . $table;
        echo "</br>";
    }
}

// Function returns a clean, stripped array of needed information
function getCleanRequirements($reqArray, $g_id){
    // initialize array to return.
    $cleanRequirements = array();
    $cleanRequirements['g_id'] = $g_id;

    // check for CPU string and put matches in new array
    $keywords= ['CPU', 'Processor', 'Processor (AMD)', 'Processor (Intel)'];
    $cpu_matches = array();
    foreach ($keywords as $keyword){
        $cpu_match = search_array_keyword($keyword, $reqArray);
        if(!empty($cpu_match)){
            array_push($cpu_matches, array_values($cpu_match));
        }
    }

    // check cpu array for number of matches and if more then 1,
    // split in Intel and AMD
    if(count($cpu_matches[0]) == 1){
        $cpu = $cpu_matches[0][0];
        // check if "/" or "or" is present and split by correct delimiter
        if(strpos($cpu, "/") !== false){
            // "/" was found, split by "/"
            $cpus = explode("/", $cpu);
        }
        else if(strpos($cpu, " or ") !== false){
            // "or" was found, split by "or"
            $cpus = explode(" or ", $cpu);
        }
        else {
            // none found so only one listed
            $cpus[0] = $cpu;
            $cpus[1] = "N/A";
        }

        // check for intel keyword in string, i for case insensitive search
        if (preg_match('/\bIntel\b/i',$cpus[0])) {
            $cpu_intel = clean_string($cpus[0]);
            $cpu_amd = clean_string($cpus[1]);
            $cleanRequirements['cpu_intel'] = $cpu_intel;
            $cleanRequirements['cpu_amd'] = $cpu_amd;
        }
        // check for intel keyword in string, i for case insensitive search
        else if (preg_match('/\bAMD\b/i',$cpus[0])) {
            $cpu_intel = clean_string($cpus[1]);
            $cpu_amd = clean_string($cpus[0]);
            $cleanRequirements['cpu_intel'] = $cpu_intel;
            $cleanRequirements['cpu_amd'] = $cpu_amd;
        }
        else {
            $cpu_amd = "N/A";
            $cpu_intel = "N/A";
            $cleanRequirements['cpu_intel'] = $cpu_intel;
            $cleanRequirements['cpu_amd'] = $cpu_amd;
        }
    }

    // if more then 1 cpu entry is found, split them in Intel and AMD
    if(count($cpu_matches[0]) > 1){
        $cpu1 = $cpu_matches[0][0];
        $cpu2 = $cpu_matches[0][1];
        // check for intel keyword in string, i for case insensitive search
        if (preg_match('/\bIntel\b/i',$cpu1)) {
            $cpu_intel = clean_string($cpu1);
            $cpu_amd = clean_string($cpu2);
            $cleanRequirements['cpu_intel'] = $cpu_intel;
            $cleanRequirements['cpu_amd'] = $cpu_amd;
        }
        // check for amd keyword in string, i for case insensitive search
        else if (preg_match('/\bAMD\b/i',$cpu1)) {
            $cpu_amd = clean_string($cpu1);
            $cpu_intel = clean_string($cpu2);
            $cleanRequirements['cpu_intel'] = $cpu_intel;
            $cleanRequirements['cpu_amd'] = $cpu_amd;
        }
        // no keywords found, so no processor assinged to amd or intel
        else{
            $cpu_amd = "N/A";
            $cpu_intel = "N/A";
            $cleanRequirements['cpu_intel'] = $cpu_intel;
            $cleanRequirements['cpu_amd'] = $cpu_amd;
        }
    }

    // check for Memory string and put matches in new array
    $keywords= ['Memory', 'Ram', 'System Memory'];
    $memory_matches = array();
    foreach ($keywords as $keyword){
        $memory_match = search_array_keyword($keyword, $reqArray);
        if(!empty($memory_match)){
            array_push($memory_matches, array_values($memory_match));
        }
    }
    //var_dump($memory_matches_min);
    $memory = $memory_matches[0][0];
    $memory = clean_string($memory);
    $cleanRequirements['memory'] = $memory;

    // Check for GPU string and put matches in new array
    $keywords= ['Graphics', 'GPU', 'Video'];
    $gpu_matches = array();
    foreach ($keywords as $keyword){
        $gpu_match = search_array_keyword($keyword, $reqArray);
        if(!empty($gpu_match)){
            array_push($gpu_matches, array_values($gpu_match));
        }
    }

    //var_dump($gpu_matches[0]);

    if(preg_match('/\bdirectx\b/i',$gpu_matches[0][1])){
        unset($gpu_matches[0][1]);
    };

    // check gpu array for number of matches and if more then 1,
    // split in nvidia and AMD
    if(count($gpu_matches[0]) == 1){
        $gpu = $gpu_matches[0][0];
        // check if "/" or "or" is present and split by correct delimiter
        if(strpos($gpu, "/") !== false){
            // "/" was found, split by "/"
            $gpus = explode("/", $gpu);
        }
        else if(strpos($gpu, " or ") !== false){
            // "or" was found, split by "or"
            $gpus = explode(" or ", $gpu);
        }
        else {
            // none found so only one listed
            $gpus[0] = $gpu;
            $gpus[1] = "N/A";
        }

        // check for nvidia keyword in string, i for case insensitive search
        if (preg_match('/\bnvidia\b/i',$gpus[0])) {
            $gpu_nvidia = clean_string($gpus[0]);
            $gpu_amd = clean_string($gpus[1]);
            $cleanRequirements['gpu_nvidia'] = $gpu_nvidia;
            $cleanRequirements['gpu_amd'] = $gpu_amd;
        }
        // check for amd keyword in string, i for case insensitive search
        else if (preg_match('/\bAMD\b/i',$gpus[0])) {
            $gpu_nvidia = clean_string($gpus[1]);
            $gpu_amd = clean_string($gpus[0]);
            $cleanRequirements['gpu_nvidia'] = $gpu_nvidia;
            $cleanRequirements['gpu_amd'] = $gpu_amd;
        }
        else {
            $gpu_amd = "N/A";
            $gpu_nvidia = "N/A";
            $cleanRequirements['gpu_nvidia'] = $gpu_nvidia;
            $cleanRequirements['gpu_amd'] = $gpu_amd;
        }
    }

    // if more then 1 gpu entry is found, split them in nvidia and AMD
    if(count($gpu_matches[0]) > 1){
        $gpu1 = $gpu_matches[0][0];
        $gpu2 = $gpu_matches[0][1];
        //var_dump($gpu1);
        //var_dump($gpu2);

        // check for nvidia keyword in string, i for case insensitive search
        if (preg_match('/\bnvidia\b/i',$gpu1)) {
            $gpu_nvidia = clean_string($gpu1);
            $gpu_amd = clean_string($gpu2);
            $cleanRequirements['gpu_nvidia'] = $gpu_nvidia;
            $cleanRequirements['gpu_amd'] = $gpu_amd;
        }
        // check for amd keyword in string, i for case insensitive search
        else if (preg_match('/\bAMD\b/i',$gpu1)) {
            $gpu_amd = clean_string($gpu1);
            $gpu_nvidia = clean_string($gpu2);
            $cleanRequirements['gpu_nvidia'] = $gpu_nvidia;
            $cleanRequirements['gpu_amd'] = $gpu_amd;
        }
        // no keywords found, so no processor assinged to amd or intel
        else{
            $gpu_amd = "N/A";
            $gpu_nvidia = "N/A";
            $cleanRequirements['gpu_nvidia'] = $gpu_nvidia;
            $cleanRequirements['gpu_amd'] = $gpu_amd;
        }
    }
    return $cleanRequirements;
}

// function to clean cpu string from unwanted characters
function clean_string($string){
    // Processor:, Processor :, CPU:, CPU :, Intel, AMD
    $string = preg_replace("/(Processor|Processor:|Processor: |Processor :|CPU:|CPU: |CPU :|Intel|AMD)/i","", $string);
    // Memory, Ram, System Memory
    $string = preg_replace("/(Memory|Memory:|Memory :|RAM:|RAM :|System Memory:| System Memory :|RAM)/i", "", $string);
    // Graphics, GPU, Video, nvidia, amd
    $string = preg_replace("/(Graphics|Card|Video|GPU|NVIDIA|AMD)/i","", $string);
    // Trademarks and copyrights
    $string = preg_replace("/(:|™|®|©|@|&trade;|&reg;|&copy;|&#8482;|&#174;|&#169;|\n)/", "", $string);
    // remove or equivalent
    $string = preg_replace("/(or equivalent)/i", "", $string);
    // strip ()
    $brackets = array('(', ')');
    $string = str_replace($brackets , '', $string);
    // strip tags
    $string = strip_tags($string);
    // trim
    $string = trim($string);
    return $string;
}

// function to convert html unordered list to array
// returns array with the list items from the ul
function ul_to_array ($ul) {
    if (is_string($ul)) {
        // encode ampersand appropiately to avoid parsing warnings
        $ul=preg_replace('/&(?!#?[a-z0-9]+;)/', '&amp;', $ul);
        if (!$ul = simplexml_load_string($ul)) {
            trigger_error("Syntax error in UL/LI structure");
            return FALSE;
        }
        return ul_to_array($ul);
    }
    else if (is_object($ul)) {
        $output = array();
        foreach ($ul->li as $li) {
        $output[] = (isset($li->ul)) ? ul_to_array($li->ul) : (string) $li;
        }
        return $output;
    } 
    else return FALSE;
}

// function to search array for a keyword
// returns an array with matching values
function search_array_keyword($keyword, $array){
    $matches = array_filter($array, function($var) use ($keyword){ return preg_match("/\b$keyword\b/i", $var);});
    return $matches;
}

?>