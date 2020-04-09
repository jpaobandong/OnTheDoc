<?php
    //Headers
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: application/json');
    header('Access-Control-Allow-Methods: DELETE');
    header('Access-Control-Allow-Headers: Access-Control-Allow-Headers, Content-Type, Access-Control-Allow-Methods, Authorization, X-Requested-With');

    include_once '../../config/Database.php';
    include_once '../../models/Clinic.php';    

    //Instantiate DB
    $database = new Database();
    $db = $database->connect();  

    //Instantiate User
    $user = new Clinic($db);

    //get raw posted data
    $data = json_decode(file_get_contents("php://input"));

    $user->id =  $data->id;

    //create user
    if($user->delete()){
        echo json_encode(
            array('message' => 'User deleted')
        ); 
    } else {
        echo json_encode(
            array('message' => 'User Not deleted')
        );
    }