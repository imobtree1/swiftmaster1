//
//  UserCell.swift
//  demo
//
//  Created by Imobtree Solutions on 3/16/18.
//  Copyright © 2018 Imobtree Solutions. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet var lblDisc: UILabel!
    @IBOutlet var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
