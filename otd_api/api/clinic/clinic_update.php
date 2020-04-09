<?php
    //Headers
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: application/json');
    header('Access-Control-Allow-Methods: PUT');
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
    $user->username = $data->username;
    $user->password = $data->password;
    $user->clinic_name = $data->clinic_name;
    $user->doctor_name = $data->doctor_name;
    $user->address = $data->address;
    $user->email = $data->email;
    $user->contact = $data->contact;

    //create user
    if($user->editClinic()){
        echo json_encode(
            array('message' => 'clinic Updated')
        ); 
    } else {
        echo json_encode(
            array('message' => 'clinic Not Updated')
        );
    }