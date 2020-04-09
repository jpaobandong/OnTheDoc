//
//  ClinicProfileVC.swift
//  OnTheDoc
//
//  Created by Paolo Bandong on 4/1/20.
//  Copyright © 2020 CITE Student. All rights reserved.
//

import UIKit
import Alamofire

class ClinicProfileVC: UIViewController {

    @IBOutlet weak var UNameTF: UITextField!
    @IBOutlet weak var CNameTF: UITextField!
    @IBOutlet weak var DNameTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var AddressTF: UITextView!
    @IBOutlet weak var ContactTF: UITextField!
    
    @IBOutlet weak var EditBtn: UIButton!
    
    var user: [String: Any] = [String: Any]()
    var currentlyEditing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNameTF.text = user["username"] as? String
        CNameTF.text = user["clinic_name"] as? String
        DNameTF.text = user["doctor_name"] as? String
        EmailTF.text = user["email"] as? String
        AddressTF.text = user["address"] as? String
        ContactTF.text = user["contact"] as? String
        
        toggleEdit(currentEdit: currentlyEditing)
        toggleColor(color: UIColor.gray)
    }
    
    func toggleEdit(currentEdit: Bool){
        UNameTF.isEnabled = currentEdit
        CNameTF.isEnabled = currentEdit
        DNameTF.isEnabled = currentEdit
        EmailTF.isEnabled = currentEdit
        AddressTF.isEditable = currentEdit
        ContactTF.isEnabled = currentEdit
    }
    
    func toggleColor(color: UIColor){
        UNameTF.backgroundColor = color
        CNameTF.backgroundColor = color
        DNameTF.backgroundColor = color
        EmailTF.backgroundColor = color
        AddressTF.backgroundColor = color
        ContactTF.backgroundColor = color
    }
    
    @IBAction func EditAction(_ sender: Any) {
        if(currentlyEditing){
            save()
            EditBtn.setTitle("Edit", for: .normal)
            currentlyEditing = false
            toggleEdit(currentEdit: currentlyEditing)
            toggleColor(color: UIColor.gray)
        }else{
            EditBtn.setTitle("Save", for: .normal)
            currentlyEditing = true
            toggleEdit(currentEdit: currentlyEditing)
            toggleColor(color: UIColor.white)
        }
    }
    
    func save(){
        if(UNameTF.text == "" || CNameTF.text == "" || DNameTF.text == "" || EmailTF.text == "" || AddressTF.text == "" || ContactTF.text == ""){
              let errormsg = UIAlertController(title: "Error", message: "Fields must not be blank!", preferredStyle: UIAlertController.Style.alert)
              errormsg.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
              self.present(errormsg, animated: true, completion: nil)
          }else{
            
            let params: Parameters = [
              "username": UNameTF.text!,
              "clinic_name": CNameTF.text!,
              "doctor_name": DNameTF.text!,
              "address": AddressTF.text!,
              "email": EmailTF.text!,
              "contact": ContactTF.text!,
              "id": user["id"] as! String,
              "password": user["password"] as! String
            ]
            
            AF.request("http://192.168.64.2/otd_api/api/clinic/clinic_update.php", method: .put, parameters: params, encoding: JSONEncoding.default )
            .responseString{response in print(response)}
            
            user = params
        }
    }
    
    @IBAction func deactivateBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Verification", message: "Are you sure you want to delete your account?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            
            let params: Parameters = [
                "id": self.user["id"] as! String
            ]
            
            AF.request("http://192.168.64.2/otd_api/api/clinic/clinic_delete.php", method: .delete, parameters: params, encoding: JSONEncoding.default )
            .responseString{response in print(response)}
            
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }

}
