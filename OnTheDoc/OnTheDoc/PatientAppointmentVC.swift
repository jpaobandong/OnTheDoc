//
//  PatientAppointmentVC.swift
//  OnTheDoc
//
//  Created by Paolo Bandong on 3/12/20.
//  Copyright © 2020 CITE Student. All rights reserved.
//

import UIKit
import Alamofire

class PatientAppointmentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userscheds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentscell", for: indexPath) as! AppointmentsCell
    
        cell.DateL.text = userscheds[indexPath.row]["date"] as? String
        cell.CNameL.text = userscheds[indexPath.row]["clinic_name"] as? String
        cell.DNameL.text = userscheds[indexPath.row]["clinic_dname"] as? String
        cell.ContactL.text = userscheds[indexPath.row]["clinic_contact"] as? String
        cell.AddressL.text = userscheds[indexPath.row]["clinic_address"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            
            let alert = UIAlertController(title: "Verification", message: "Are you sure you want to remove this appointment?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                
                let params: Parameters = [
                    "id": self.userscheds[indexPath.row]["id"] as! String
                ]
                
                AF.request("http://192.168.64.2/otd_api/api/sched/sched_delete.php", method: .delete, parameters: params, encoding: JSONEncoding.default )
                .responseString{response in print(response)}
                
                self.userscheds.remove(at: indexPath.row)
                tableView.reloadData()
                
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

            self.present(alert, animated: true)
            
            
        }
    }
    
    var user: [String: Any] = [String: Any]()
    var clinics: [[String: Any]] = [[String: Any]]()
    var scheds:[[String: Any]] = [[String: Any]]()
    var userscheds:[[String: Any]] = [[String: Any]]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 230
        filterData()
        
    }

    func filterData(){
        
        scheds.forEach({s in
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat =  "MMMM dd, yyyy hh:mm:ss"
            
            var stringdate = s["date"] as! String
            stringdate.append(" 08:00:00")
            
            let schedDate = dateFormatter.date(from: stringdate)!
            var currentDate = Date()
            let timeint = TimeInterval((8.0 * 60.0)*60.0)
            currentDate.addTimeInterval(timeint)
            
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            var currString = dateFormatter.string(from: currentDate)
            currString.append(" 08:00:00")
            dateFormatter.dateFormat =  "MMMM dd, yyyy hh:mm:ss"
            let newcurrentDate = dateFormatter.date(from: currString)!
            
            if( s["user_id"] as! String == user["id"] as! String && schedDate >= newcurrentDate){
                userscheds.append(s)
                
            }
        })
        
    }

    @IBAction func SetAppointBtn(_ sender: Any) {
        performSegue(withIdentifier: "segToSet", sender: self)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navcon = segue.destination as! UINavigationController
        let vc = navcon.topViewController as! SetAppointment
        vc.modalPresentationStyle = .fullScreen
        vc.clinics = clinics
        vc.user = self.user
    }

}
