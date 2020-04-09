//
//  PatientSignupVC.swift
//  OnTheDoc
//
//  Created by CITE Student on 2/28/20.
//  Copyright © 2020 CITE Student. All rights reserved.
//

import UIKit
import Alamofire

class PatientSignupVC: UIViewController {

    @IBOutlet weak var UsernameTF: UITextField!
    @IBOutlet weak var FirstNameTF: UITextField!
    @IBOutlet weak var LastNameTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var AddressTF: UITextView!
    @IBOutlet weak var ContactTF: UITextField!
    @IBOutlet weak var BirthdatePicker: UIDatePicker!
    @IBOutlet weak var PasswordTF: UITextField!
    @IBOutlet weak var ConfirmTF: UITextField!
   
        
        override func viewDidLoad() {
            super.viewDidLoad()
            PasswordTF.isSecureTextEntry = true
            ConfirmTF.isSecureTextEntry = true
            // Do any additional setup after loading the view.
        }
        
        @IBAction func SignupBtn(_ sender: Any){
            if(UsernameTF.text == "" || FirstNameTF.text == "" || LastNameTF.text == "" || EmailTF.text == "" || AddressTF.text == "" || ContactTF.text == "" || PasswordTF.text == "" || ConfirmTF.text == ""){
                let errormsg = UIAlertController(title: "Error", message: "Fields must not be blank!", preferredStyle: UIAlertController.Style.alert)
                errormsg.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(errormsg, animated: true, completion: nil)
            }else if(PasswordTF.text != ConfirmTF.text){
                let errormsg = UIAlertController(title: "Error", message: "Password does not match", preferredStyle: UIAlertController.Style.alert)
                errormsg.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(errormsg, animated: true, completion: nil)
            }else{
              let timeFormatter = DateFormatter()
              timeFormatter.dateFormat = "MMMM d, YYYY"
              
              let params: Parameters = [
                "username": UsernameTF.text!,
                "password": PasswordTF.text!,
                "firstname": FirstNameTF.text!,
                "lastname": LastNameTF.text!,
                "address": AddressTF.text!,
                "email": EmailTF.text!,
                "mobilenum": ContactTF.text!,
                "birthdate": timeFormatter.string(from: BirthdatePicker.date)
                
              ]
              
              AF.request("http://192.168.64.2/otd_api/api/user/create.php", method: .post, parameters: params, encoding: JSONEncoding.default)
              .responseJSON{response in print(response)}
                
              self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
          }
        }
    
        @IBAction func BackBtn(_ sender: Any) {
            dismiss(animated: true, completion: nil)
        }
        

    }
