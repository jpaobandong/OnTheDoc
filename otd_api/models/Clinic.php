<?php
    class Clinic{
        //DB Properties
        private $conn;
        private $table = 'clinic';

        //User Properties
        public $id;
        public $username;
        public $password;
        public $clinic_name;
        public $doctor_name;
        public $email;
        public $address;
        public $contact;

        //Constructor
        public function __construct($db){
            $this->conn = $db;
        }

        public function getAll(){
            //create query
            $query = 'SELECT * FROM ' . $this->table;
            
            //prepare statement
            $stmt = $this->conn->prepare($query);

            //Execute query
            $stmt->execute();

            return $stmt;
        }

        public function getUserByUsername(){
            //create query
            $query = 'SELECT * FROM ' . $this->table . ' WHERE username=?';
            //prepare statement
            $stmt = $this->conn->prepare($query);

            //BIND ID
            $stmt->bindParam(1, $this->username);

            //Execute query
            $stmt->execute();

            $row = $stmt->fetch(PDO::FETCH_ASSOC);

            //set properties
            $this->id = $row['id'];
            $this->username = $row['username'];
            $this->password = $row['password'];
            $this->clinic_name = $row['clinic_name'];
            $this->doctor_name = $row['doctor_name'];
            $this->address = $row['address'];
            $this->email = $row['email'];
            $this->contact = $row['contact'];
        }

        //create user
        public function createUser(){
            //create query
            $query = 'INSERT INTO ' . $this->table . 
            ' SET 
            username = :username,
            password = :password,
            clinic_name = :clinic_name,
            doctor_name = :doctor_name,
            address = :address,
            email = :email,
            contact = :contact
            ';
            echo $query;
            //prepare statement
            $stmt = $this->conn->prepare($query);

            //clean data
            $this->username = htmlspecialchars(strip_tags($this->username));
            $this->password = htmlspecialchars(strip_tags($this->password));
            $this->clinic_name = htmlspecialchars(strip_tags($this->clinic_name));
            $this->doctor_name = htmlspecialchars(strip_tags($this->doctor_name));
            $this->address = htmlspecialchars(strip_tags($this->address));
            $this->email = htmlspecialchars(strip_tags($this->email));
            $this->contact = htmlspecialchars(strip_tags($this->contact));

            //bind data
            $stmt->bindParam(':username', $this->username);
            $stmt->bindParam(':password', $this->password);
            $stmt->bindParam(':clinic_name', $this->clinic_name);
            $stmt->bindParam(':doctor_name', $this->doctor_name);
            $stmt->bindParam(':address', $this->address);
            $stmt->bindParam(':email', $this->email);
            $stmt->bindParam(':contact', $this->contact);

            //execute query
            if($stmt->execute()){
                return true;
            }
            printf("Error: %s.\n", $stmt->error);

            return false;
        }

        public function editClinic(){
            //create query
            $query = 'UPDATE ' . $this->table . 
            ' SET 
            username = :username,
            password = :password,
            clinic_name = :clinic_name,
            doctor_name = :doctor_name,
            address = :address,
            email = :email,
            contact = :contact 
            WHERE id = :id
            ';
            //prepare statement
            $stmt = $this->conn->prepare($query);

            //clean data
            $this->username = htmlspecialchars(strip_tags($this->username));
            $this->password = htmlspecialchars(strip_tags($this->password));
            $this->clinic_name = htmlspecialchars(strip_tags($this->clinic_name));
            $this->doctor_name = htmlspecialchars(strip_tags($this->doctor_name));
            $this->address = htmlspecialchars(strip_tags($this->address));
            $this->email = htmlspecialchars(strip_tags($this->email));
            $this->contact = htmlspecialchars(strip_tags($this->contact));
            $this->id = htmlspecialchars(strip_tags($this->id));

            //bind data
            $stmt->bindParam(':username', $this->username);
            $stmt->bindParam(':password', $this->password);
            $stmt->bindParam(':clinic_name', $this->clinic_name);
            $stmt->bindParam(':doctor_name', $this->doctor_name);
            $stmt->bindParam(':address', $this->address);
            $stmt->bindParam(':email', $this->email);
            $stmt->bindParam(':contact', $this->contact);
            $stmt->bindParam(':id', $this->id);

            //execute query
            if($stmt->execute()){
                return true;
            }
            printf("Error: %s.\n", $stmt->error);

            return false;
        }

        public function delete(){
            $query = 'DELETE FROM ' . $this->table . ' WHERE id = :id';

            //prepare statement
            $stmt = $this->conn->prepare($query);

            $this->id = htmlspecialchars(strip_tags($this->id));

            $stmt->bindParam(':id', $this->id);

            if($stmt->execute()){
                return true;
            }
            printf("Error: %s.\n", $stmt->error);

            return false;
        }
    }