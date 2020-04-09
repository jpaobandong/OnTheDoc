<?php
    //Headers
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: application/json');

    include_once '../../config/Database.php';
    include_once '../../models/User.php';    

    //Instantiate DB
    $database = new Database();
    $db = $database->connect();  

    //Instantiate User
    $user = new User($db);

    //get username
    $user->username = isset($_GET['username']) ? $_GET['username'] : die();

    //get by username
    $user->getUserByUsername();

    //create array
    $user_array = array(
        'id' => $user->id,
        'username' => $user->username,
        'password' => $user->password,
        'firstname' => $user->firstname,
        'lastname' => $user->lastname,
        'address' => $user->address,
        'email' => $user->email,
        'mobilenum' => $user->mobilenum,
        'birthdate' => $user->birthdate,
    );

    //make json
    print_r(json_encode($user_array));