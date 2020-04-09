<?php
    //Headers
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: application/json');
    header('Access-Control-Allow-Methods: PUT');
    header('Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With');

    include_once '../../config/Database.php';
    include_once '../../models/User.php';    

    //Instantiate DB
    $database = new Database();
    $db = $database->connect();  

    //Instantiate User
    $user = new User($db);

    //get raw posted data
    $data = json_decode(file_get_contents("php://input"));

    $user->id =  $data->id;
    $user->username = $data->username;
    $user->password = $data->password;
    $user->firstname = $data->firstname;
    $user->lastname = $data->lastname;
    $user->address = $data->address;
    $user->email = $data->email;
    $user->mobilenum = $data->mobilenum;
    $user->birthdate = $data->birthdate;

    //create user
    if($user->update()){
        echo json_encode(
            array('message' => 'User Updated')
        ); 
    } else {
        echo json_encode(
            array('message' => 'User Not Updated')
        );
    }