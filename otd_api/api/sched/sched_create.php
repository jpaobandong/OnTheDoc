<?php
    //Headers
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: application/json');
    header('Access-Control-Allow-Methods: POST');
    header('Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With');

    include_once '../../config/Database.php';
    include_once '../../models/Schedule.php';    

    //Instantiate DB
    $database = new Database();
    $db = $database->connect();  

    //Instantiate User
    $user = new Schedule($db);

    //get raw posted data
    $data = json_decode(file_get_contents("php://input"));

    $user->date = $data->date;
    $user->clinic_id = $data->clinic_id;
    $user->user_id = $data->user_id;

    //create user
    if($user->createSched()){
        echo json_encode(
            array('message' => 'User Created')
        ); 
    } else {
        echo json_encode(
            array('message' => 'User Not Created')
        );
    }