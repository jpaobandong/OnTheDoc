//
//  PatientProfileVC.swift
//  OnTheDoc
//
//  Created by Paolo Bandong on 3/31/20.
//  Copyright © 2020 CITE Student. All rights reserved.
//

import UIKit
import Alamofire

class PatientProfileVC: UIViewController {

    @IBOutlet weak var UsernameTF: UITextField!
    @IBOutlet weak var FirstNameTF: UITextField!
    @IBOutlet weak var LastNameTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var AddressTF: UITextView!
    @IBOutlet weak var ContactTF: UITextField!
    @IBOutlet weak var BirthdatePicker: UIDatePicker!
    @IBOutlet weak var EditBtn: UIButton!
    
    var currentlyEditing = false
    
    var user: [String: Any] = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UsernameTF.text = user["username"] as? String
        FirstNameTF.text = user["firstname"] as? String
        LastNameTF.text = user["lastname"] as? String
        EmailTF.text = user["email"] as? String
        AddressTF.text = user["address"] as? String
        ContactTF.text = user["mobilenum"] as? String
        
        var bday = user["birthdate"] as! String
        bday.append(" 08:00:00")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "MMMM dd, yyyy hh:mm:ss"
        dateFormatter.locale = NSLocale.current
        let date = dateFormatter.date(from: bday)
       
        BirthdatePicker.date = date!
        toggleEdit(currentedit: currentlyEditing)
        toggleColor(color: UIColor.gray)
    }
    
    func toggleEdit(currentedit: Bool){
        UsernameTF.isEnabled = currentedit
        FirstNameTF.isEnabled = currentedit
        LastNameTF.isEnabled = currentedit
        EmailTF.isEnabled = currentedit
        AddressTF.isEditable = currentedit
        ContactTF.isEnabled = currentedit
        BirthdatePicker.isEnabled = currentedit
    }
    
    func toggleColor(color: UIColor){
        UsernameTF.backgroundColor = color
        FirstNameTF.backgroundColor = color
        LastNameTF.backgroundColor = color
        EmailTF.backgroundColor = color
        AddressTF.backgroundColor = color
        ContactTF.backgroundColor = color
        BirthdatePicker.backgroundColor = color
    }
    
    func save(){
        if(UsernameTF.text == "" || FirstNameTF.text == "" || LastNameTF.text == "" || EmailTF.text == "" || AddressTF.text == "" || ContactTF.text == "" ){
            let errormsg = UIAlertController(title: "Error", message: "Fields must not be blank!", preferredStyle: UIAlertController.Style.alert)
            errormsg.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(errormsg, animated: true, completion: nil)
        }else{
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "MMMM d, YYYY"
            
            let params: Parameters = [
                "username": UsernameTF.text!,
                "firstname": FirstNameTF.text!,
                "lastname": LastNameTF.text!,
                "address": AddressTF.text!,
                "email": EmailTF.text!,
                "mobilenum": ContactTF.text!,
                "birthdate": timeFormatter.string(from: BirthdatePicker.date),
                "id": user["id"] as! String,
                "password": user["password"] as! String
            ]
            
            AF.request("http://192.168.64.2/otd_api/api/user/update.php", method: .put, parameters: params, encoding: JSONEncoding.default )
            .responseString{response in print(response)}
            
            user = params
        }
    }
    
    @IBAction func EditAction(_ sender: Any) {
        if(currentlyEditing){
            save()
            EditBtn.setTitle("Edit", for: .normal)
            currentlyEditing = false
            toggleEdit(currentedit: currentlyEditing)
            toggleColor(color: UIColor.gray)
        }else{
            EditBtn.setTitle("Save", for: .normal)
            currentlyEditing = true
            toggleEdit(currentedit: currentlyEditing)
            toggleColor(color: UIColor.white)
        }
    }
    
    @IBAction func deactivateBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Verification", message: "Are you sure you want to delete your account?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            
            let params: Parameters = [
                "id": self.user["id"] as! String
            ]
            
            AF.request("http://192.168.64.2/otd_api/api/user/delete.php", method: .delete, parameters: params, encoding: JSONEncoding.default )
            .responseString{response in print(response)}
            
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    
}
