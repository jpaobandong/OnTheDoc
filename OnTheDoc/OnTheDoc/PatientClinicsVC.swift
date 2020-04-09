//
//  PatientClinicsVC.swift
//  OnTheDoc
//
//  Created by Paolo Bandong on 3/12/20.
//  Copyright © 2020 CITE Student. All rights reserved.
//

import UIKit

class PatientClinicsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TV: UITableView!
    var clinics: [[String: Any]] = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TV.rowHeight = 240.0
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clinics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cliniccell", for: indexPath) as! ClinicListCell
        
        cell.ClinicL.text = clinics[indexPath.row]["clinic_name"] as? String
        cell.DoctorL.text = clinics[indexPath.row]["doctor_name"] as? String
        cell.PhoneL.text = clinics[indexPath.row]["contact"] as? String
        cell.EmailL.text = clinics[indexPath.row]["email"] as? String
        cell.AddressL.text = clinics[indexPath.row]["address"] as? String
        
        
        return cell
    }
    
}
