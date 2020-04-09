//
//  LoginVC.swift
//  OnTheDoc
//
//  Created by CITE Student on 2/21/20.
//  Copyright © 2020 CITE Student. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {

    @IBOutlet weak var unametf: UITextField!
    @IBOutlet weak var pwordtf: UITextField!
    
    var users: [[String: Any]] = [[String: Any]]()
    var u: [String: Any] = [String: Any]()
    var clinics: [[String: Any]] = [[String: Any]]()
    var s: [[String: Any]] = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pwordtf.isSecureTextEntry = true
        
        AF.request("http://192.168.64.2/otd_api/api/user/read.php")
        .responseJSON{
            response in
            if let responseValue = response.value as! [String: Any]? {
                if let responseUsers = responseValue["data"] as! [[String: Any]]?{
                    self.users = responseUsers
                }
            }
        }
        
        AF.request("http://192.168.64.2/otd_api/api/clinic/clinic_read.php")
        .responseJSON{
            response in
            if let responseValue = response.value as! [String: Any]? {
                if let responseUsers = responseValue["data"] as! [[String: Any]]?{
                    self.clinics = responseUsers
                }
            }
        }
        
        AF.request("http://192.168.64.2/otd_api/api/sched/sched_read.php")
        .responseJSON{
            response in
            if let responseValue = response.value as! [String: Any]? {
                if let responseUsers = responseValue["data"] as! [[String: Any]]?{
                    self.s = responseUsers
                }
            }
        }
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let uname = unametf.text!
        let pword = pwordtf.text!
        var doesExist = false
        var type = ""
        
        users.forEach({user in
            if(user["username"] as! String == uname && user["password"] as! String == pword){
                doesExist = true
                type = "patient"
                u = user
            }
        })
        
        clinics.forEach({clinic in
            if(clinic["username"] as! String == uname && clinic["password"] as! String == pword){
                doesExist = true
                type = "clinic"
                u = clinic
            }
        })
        
        if(doesExist){
            if(type == "patient"){
                performSegue(withIdentifier: "segToHomePatient", sender: self)
            }else{
                performSegue(withIdentifier: "segToHomeClinic", sender: self)
            }
        }else{
            let errormsg = UIAlertController(title: "Error", message: "Invalid Credentials", preferredStyle: UIAlertController.Style.alert)
            errormsg.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(errormsg, animated: true, completion: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let tbc = segue.destination as! UITabBarController
        tbc.modalPresentationStyle = .fullScreen
        
        if segue.identifier == "segToHomePatient" {
            
            let vc = tbc.viewControllers![0] as! PatientAppointmentVC
            vc.user = u
            vc.clinics = clinics
            vc.scheds = s
            
            
            let vc2 = tbc.viewControllers![1] as! PatientClinicsVC
            vc2.clinics = clinics
            
            let vc3 = tbc.viewControllers![2] as! PatientProfileVC
            vc3.user = u
            
        }else if segue.identifier == "segToHomeClinic" {
            
            
            let vc = tbc.viewControllers![0] as! ClinicAppointmentVC
            vc.user = u
            vc.scheds = s
            
            let vc2 = tbc.viewControllers![1] as! ClinicProfileVC
            vc2.user = u
        }
    }
    


}
