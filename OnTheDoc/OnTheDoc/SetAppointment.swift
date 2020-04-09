//
//  SetAppointment.swift
//  OnTheDoc
//
//  Created by Paolo Bandong on 3/12/20.
//  Copyright © 2020 CITE Student. All rights reserved.
//

import UIKit
import Alamofire

class CellClass: UITableViewCell{
    
}

class SetAppointment: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var clinics: [[String: Any]] = [[String: Any]]()
    var user: [String: Any] = [String: Any]()
    
    @IBOutlet weak var SelectClinic: UIButton!
    @IBOutlet weak var SetDateDP: UIDatePicker!
    
    let transparentView = UIView()
    let tableView = UITableView()
    
    var selectedButton = UIButton()
    
    var selectedClinicName = ""
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        clinics.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = clinics[indexPath.row]["clinic_name"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedClinicName = (clinics[indexPath.row]["clinic_name"] as? String)!
        selectedButton.setTitle(clinics[indexPath.row]["clinic_name"] as? String, for: .normal)
        removeTransparentView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CellClass.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    
    func addTransparentView(frames: CGRect){
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        
        self.view.addSubview(tableView)
        tableView.layer.cornerRadius = 5
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView.reloadData()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.clinics.count * 50))
            
        }, completion: nil)
        
    }
     
    @objc func removeTransparentView(){
        let frames = selectedButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.0
            self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
            
        }, completion: nil)
    }
    
    @IBAction func SelectClinicOnClick(_ sender: Any) {
        selectedButton = SelectClinic
        addTransparentView(frames: SelectClinic.frame)
    }
    
    @IBAction func SetBtn(_ sender: UIButton) {
        var clinic_id = ""
        
        if(selectedClinicName == ""){
            let errormsg = UIAlertController(title: "Error", message: "Please Select Clinic", preferredStyle: UIAlertController.Style.alert)
            errormsg.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(errormsg, animated: true, completion: nil)
        }else{
            clinics.forEach({
                clinic in
                if(clinic["clinic_name"] as? String == selectedClinicName){
                    clinic_id = clinic["id"] as! String                }
            })
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "MMMM d, YYYY"
            
            let params: Parameters = [
              "clinic_id": clinic_id,
              "user_id": user["id"] as Any,
              "date": timeFormatter.string(from: SetDateDP.date)
              
            ]
            
            AF.request("http://192.168.64.2/otd_api/api/sched/sched_create.php", method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseJSON{response in print(response)}
              
            let errormsg = UIAlertController(title: "Success", message: "Appointment Set!", preferredStyle: UIAlertController.Style.alert)
            errormsg.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(errormsg, animated: true, completion: nil)
            
        }
        
        
        
        
    }
    
    @IBAction func BackBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}


