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
                'username' => $username,
                'password' => $password,
                'firstname' => $firstname,
                'lastname' => $lastname,
                'address' => $address,
                'email' => $email,
                'mobilenum' => $mobilenum,
                'birthdate' => $birthdate,
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