//
//  ClinicListCell.swift
//  OnTheDoc
//
//  Created by Paolo Bandong on 3/12/20.
//  Copyright © 2020 CITE Student. All rights reserved.
//

import UIKit

class ClinicListCell: UITableViewCell {

    @IBOutlet weak var ClinicL: UILabel!
    @IBOutlet weak var DoctorL: UILabel!
    @IBOutlet weak var PhoneL: UILabel!
    @IBOutlet weak var EmailL: UILabel!
    @IBOutlet weak var AddressL: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        AddressL.lineBreakMode = NSLineBreakMode.byWordWrapping
        AddressL.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
