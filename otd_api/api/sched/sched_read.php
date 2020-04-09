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

    //Query
    $result = $user->getAll();
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

            //push to data
            array_push($user_arr['data'], $user_item);
        }

        //turn to json and ouput
        echo json_encode($user_arr);


    }else{
        echo json_encode(
            array('message' => 'No Users Found')
        );
    }