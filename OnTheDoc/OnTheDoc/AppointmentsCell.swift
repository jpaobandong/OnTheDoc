//
//  AppointmentsCell.swift
//  OnTheDoc
//
//  Created by Paolo Bandong on 3/13/20.
//  Copyright © 2020 CITE Student. All rights reserved.
//

import UIKit

class AppointmentsCell: UITableViewCell {

    @IBOutlet weak var DateL: UILabel!
    @IBOutlet weak var CNameL: UILabel!
    @IBOutlet weak var DNameL: UILabel!
    @IBOutlet weak var ContactL: UILabel!
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
