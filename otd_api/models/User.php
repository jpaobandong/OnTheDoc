<?php
    class User{
        //DB Properties
        private $conn;
        private $table = 'user';

        //User Properties
        public $id;
        public $username;
        public $password;
        public $firstname;
        public $lastname;
        public $address;
        public $email;
        public $mobilenum;
        public $birthdate; 

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
            $this->firstname = $row['firstname'];
            $this->lastname = $row['lastname'];
            $this->address = $row['address'];
            $this->email = $row['email'];
            $this->mobilenum = $row['mobilenum'];
            $this->birthdate = $row['birthdate'];
        }

        //create user
        public function createUser(){
            //create query
            $query = 'INSERT INTO ' . $this->table . 
            ' SET 
            username = :username,
            password = :password,
            firstname = :firstname,
            lastname = :lastname,
            address = :address,
            email = :email,
            mobilenum = :mobilenum,
            birthdate = :birthdate
            ';
            //prepare statement
            $stmt = $this->conn->prepare($query);

            //clean data
            $this->username = htmlspecialchars(strip_tags($this->username));
            $this->password = htmlspecialchars(strip_tags($this->password));
            $this->firstname = htmlspecialchars(strip_tags($this->firstname));
            $this->lastname = htmlspecialchars(strip_tags($this->lastname));
            $this->address = htmlspecialchars(strip_tags($this->address));
            $this->email = htmlspecialchars(strip_tags($this->email));
            $this->mobilenum = htmlspecialchars(strip_tags($this->mobilenum));
            $this->birthdate = htmlspecialchars(strip_tags($this->birthdate));

            //bind data
            $stmt->bindParam(':username', $this->username);
            $stmt->bindParam(':password', $this->password);
            $stmt->bindParam(':firstname', $this->firstname);
            $stmt->bindParam(':lastname', $this->lastname);
            $stmt->bindParam(':address', $this->address);
            $stmt->bindParam(':email', $this->email);
            $stmt->bindParam(':mobilenum', $this->mobilenum);
            $stmt->bindParam(':birthdate', $this->birthdate);

            //execute query
            if($stmt->execute()){
                return true;
            }
            printf("Error: %s.\n", $stmt->error);

            return false;
        }

        public function update(){
            //create query
            $query = 'UPDATE ' . $this->table . 
            ' SET 
            username = :username,
            password = :password,
            firstname = :firstname,
            lastname = :lastname,
            address = :address,
            email = :email,
            mobilenum = :mobilenum,
            birthdate = :birthdate 
            WHERE 
            id = :id
            ';
            //prepare statement
            $stmt = $this->conn->prepare($query);

            //clean data
            $this->username = htmlspecialchars(strip_tags($this->username));
            $this->password = htmlspecialchars(strip_tags($this->password));
            $this->firstname = htmlspecialchars(strip_tags($this->firstname));
            $this->lastname = htmlspecialchars(strip_tags($this->lastname));
            $this->address = htmlspecialchars(strip_tags($this->address));
            $this->email = htmlspecialchars(strip_tags($this->email));
            $this->mobilenum = htmlspecialchars(strip_tags($this->mobilenum));
            $this->birthdate = htmlspecialchars(strip_tags($this->birthdate));
            $this->id = htmlspecialchars(strip_tags($this->id));

            //bind data
            $stmt->bindParam(':username', $this->username);
            $stmt->bindParam(':password', $this->password);
            $stmt->bindParam(':firstname', $this->firstname);
            $stmt->bindParam(':lastname', $this->lastname);
            $stmt->bindParam(':address', $this->address);
            $stmt->bindParam(':email', $this->email);
            $stmt->bindParam(':mobilenum', $this->mobilenum);
            $stmt->bindParam(':birthdate', $this->birthdate);
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