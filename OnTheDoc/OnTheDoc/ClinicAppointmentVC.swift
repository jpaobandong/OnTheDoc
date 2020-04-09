//
//  ClinicAppointmentVC.swift
//  OnTheDoc
//
//  Created by Paolo Bandong on 4/1/20.
//  Copyright © 2020 CITE Student. All rights reserved.
//

import UIKit

class ClinicAppointmentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedsForToday.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentscell", for: indexPath) as! ClinicAppointmentsCell
        
        cell.DateL.text = schedsForToday[indexPath.row]["date"] as? String
        
        let fname = schedsForToday[indexPath.row]["user_fname"] as! String
        let lname = schedsForToday[indexPath.row]["user_lname"] as! String
        
        cell.NameL.text = fname + " " + lname
        cell.ContactL.text = schedsForToday[indexPath.row]["user_contact"] as? String
        cell.AddressL.text = schedsForToday[indexPath.row]["user_address"] as? String
        cell.EmailL.text = schedsForToday[indexPath.row]["user_email"] as? String
        
        return cell
    }
    
    @IBOutlet weak var tableView: UITableView!
    var user: [String: Any] = [String: Any]()
    var scheds:[[String: Any]] = [[String: Any]]()
    var schedsForToday:[[String: Any]] = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterData()
        tableView.rowHeight = 230
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
            
            if( s["user_id"] as! String == user["id"] as! String && schedDate == newcurrentDate){
                schedsForToday.append(s)
                
            }
        })
        
    }

}
