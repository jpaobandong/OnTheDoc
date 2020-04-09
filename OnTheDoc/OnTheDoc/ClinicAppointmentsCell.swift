//
//  ClinicAppointmentsCell.swift
//  OnTheDoc
//
//  Created by Paolo Bandong on 4/1/20.
//  Copyright © 2020 CITE Student. All rights reserved.
//

import UIKit

class ClinicAppointmentsCell: UITableViewCell {

    
    @IBOutlet weak var DateL: UILabel!
    @IBOutlet weak var NameL: UILabel!
    @IBOutlet weak var EmailL: UILabel!
    @IBOutlet weak var ContactL: UILabel!
    @IBOutlet weak var AddressL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
