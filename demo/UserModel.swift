//
//  UserModel.swift
//  demo
//
//  Created by Imobtree Solutions on 3/16/18.
//  Copyright © 2018 Imobtree Solutions. All rights reserved.
//

import Foundation
import SwiftyJSON


class UserModel {
    var userId:String?
    var name:String?
    var body:String?
    var add:address?
    
    init(res:JSON) {
        userId = res["id"].stringValue
        name = res["name"].stringValue
        body = res["body"].stringValue
        add = address(address:res["address"])
    }
}

class address {
    var street:String?
    var city:String?
    
    init(address:JSON) {
        street = address["street"].stringValue
        city = address["city"].stringValue
    }
}
