//
//  ClinicSignupVC.swift
//  OnTheDoc
//
//  Created by Paolo Bandong on 3/12/20.
//  Copyright © 2020 CITE Student. All rights reserved.
//

import UIKit
import Alamofire

class ClinicSignupVC: UIViewController {
    
    @IBOutlet weak var UNameTF: UITextField!
    @IBOutlet weak var CNameTF: UITextField!
    @IBOutlet weak var DNameTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var AddressTF: UITextView!
    @IBOutlet weak var ContactTF: UITextField!
    @IBOutlet weak var PWordTF: UITextField!
    @IBOutlet weak var ConfirmTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        PWordTF.isSecureTextEntry = true
        ConfirmTF.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func CSignup(_ sender: UIButton) {
        if(UNameTF.text == "" || CNameTF.text == "" || DNameTF.text == "" || EmailTF.text == "" || AddressTF.text == "" || ContactTF.text == "" || PWordTF.text == "" || ConfirmTF.text == ""){
              let errormsg = UIAlertController(title: "Error", message: "Fields must not be blank!", preferredStyle: UIAlertController.Style.alert)
              errormsg.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
              self.present(errormsg, animated: true, completion: nil)
          }else if(PWordTF.text != ConfirmTF.text){
              let errormsg = UIAlertController(title: "Error", message: "Password does not match", preferredStyle: UIAlertController.Style.alert)
              errormsg.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
              self.present(errormsg, animated: true, completion: nil)
          }else{
            
            let params: Parameters = [
              "username": UNameTF.text!,
              "password": PWordTF.text!,
              "clinic_name": CNameTF.text!,
              "doctor_name": DNameTF.text!,
              "address": AddressTF.text!,
              "email": EmailTF.text!,
              "contact": ContactTF.text!,
              
            ]
            
            AF.request("http://192.168.64.2/otd_api/api/clinic/clinic_create.php", method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON{response in print(response)}
              
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func BackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
