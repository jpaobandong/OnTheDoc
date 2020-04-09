<?php
    class Schedule{
        //DB Properties
        private $conn;
        private $table = 'schedule';

        //User Properties
        public $id;
        public $date;
        public $clinic_name;
        public $clinic_dname;
        public $clinic_id;
        public $clinic_email;
        public $clinic_contact;
        public $clinic_address;
        public $user_id;
        public $user_fname;
        public $user_lname;
        public $user_email;
        public $user_contact;
        public $user_address;

        //Constructor
        public function __construct($db){
            $this->conn = $db;
        }

        public function getAll(){
            $query = 'SELECT 
                c.clinic_name as clinic_name,
                c.doctor_name as clinic_dname,
                c.email as clinic_email,
                c.contact as clinic_contact,
                c.address as clinic_address,
                u.firstname as user_fname,
                u.lastname as user_lname,
                u.email as user_email,
                u.mobilenum as user_contact,
                u.address as user_address,
                s.id,
                s.date,
                s.user_id,
                s.clinic_id 
                FROM '. $this->table .' s
                LEFT JOIN
                clinic c ON s.clinic_id = c.id 
                LEFT JOIN
                user u ON s.user_id = u.id';

            $stmt = $this->conn->prepare($query);

            $stmt->execute();

            return $stmt;
            
        }

        public function getSchedByUserId(){
            $query = 'SELECT 
                c.clinic_name as clinic_name,
                c.doctor_name as clinic_dname,
                c.email as clinic_email,
                c.contact as clinic_contact,
                c.address as clinic_address,
                u.firstname as user_fname,
                u.lastname as user_lname,
                u.email as user_email,
                u.mobilenum as user_contact,
                u.address as user_address,
                s.id,
                s.date,
                s.user_id,
                s.clinic_id 
                FROM '. $this->table .' s
                LEFT JOIN
                clinic c ON s.clinic_id = c.id 
                LEFT JOIN
                user u ON s.user_id = u.id
                WHERE s.user_id = :user_id
                ';
            $stmt = $this->conn->prepare($query);

            $this->user_id = htmlspecialchars(strip_tags($this->user_id));
            $stmt->bindParam(':user_id', $this->user_id);
            
            $stmt->execute();

            
            return $stmt;
            
        }

        //create user
        public function createSched(){
            //create query
            $query = 'INSERT INTO ' . $this->table . 
            ' SET 
            date = :date,
            clinic_id = :clinic_id,
            user_id = :user_id
            ';
            //prepare statement
            $stmt = $this->conn->prepare($query);

            //clean data
            $this->date = htmlspecialchars(strip_tags($this->date));
            $this->clinic_id = htmlspecialchars(strip_tags($this->clinic_id));
            $this->user_id = htmlspecialchars(strip_tags($this->user_id));

            //bind data
            $stmt->bindParam(':date', $this->date);
            $stmt->bindParam(':clinic_id', $this->clinic_id);
            $stmt->bindParam(':user_id', $this->user_id);

            //execute query
            if($stmt->execute()){
                return true;
            }
            printf("Error: %s.\n", $stmt->error);

            return false;
        }

        public function deleteSched(){
            //create query
            $query = 'DELETE FROM ' . $this->table . ' WHERE id = :id';
            //prepare statement
            $stmt = $this->conn->prepare($query);

            //clean data
            $this->id = htmlspecialchars(strip_tags($this->id));

            //bind data
            $stmt->bindParam(':id', $this->id);

            //execute query
            if($stmt->execute()){
                return true;
            }
            printf("Error: %s.\n", $stmt->error);

            return false;
        }
    }