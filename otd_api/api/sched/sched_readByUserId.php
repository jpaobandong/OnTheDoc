<?php
    //Headers
    header('Access-Control-Allow-Origin: *');
    header('Content-Type: application/json');

    include_once '../../config/Database.php';
    include_once '../../models/Schedule.php';    

    //Instantiate DB
    $database = new Database();
    $db = $database->connect();  

    //Instantiate User
    $user = new Schedule($db);

    //get raw posted data
    $data = json_decode(file_get_contents("php://input"));

    //get username
    $user->user_id = $data->user_id;

    $result = $user->getSchedByUserId();
    $num = $result->rowCount();
    
    if($num > 0){
        $user_arr = array();
        $user_arr['data'] = array();

        while($row = $result->fetch(PDO::FETCH_ASSOC)){
            extract($row);

            $user_item = array(
                'id' => $id,
                'clinic_id' => $clinic_id,
                'user_id' => $user_id,
                'date' => $date,
                'clinic_name' => $clinic_name,
                'clinic_dname' => $clinic_dname,
                'clinic_email' => $clinic_email,
                'clinic_contact' => $clinic_contact,
                'clinic_address' => $clinic_address,
                'user_fname' => $user_fname,
                'user_lname' => $user_lname,
                'user_contact' => $user_contact,
                'user_email' => $user_email,
                'user_address' => $user_address
            );
            array_push($user_arr['data'], $user_item);
        }
        //push to data
        
        echo json_encode($user_arr);

    }

    


    