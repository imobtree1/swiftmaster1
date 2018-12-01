//
//  ListCell.swift
//  CoreData
//
//  Created by ravi-macmini on 29/11/18.
//  Copyright © 2018 milan-macmini. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblNumber: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
