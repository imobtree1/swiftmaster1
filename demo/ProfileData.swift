//
//  ProfileData.swift
//  demo
//
//  Created by Imobtree Solutions on 3/16/18.
//  Copyright © 2018 Imobtree Solutions. All rights reserved.
//

import UIKit
import RealmSwift

class Profile:Object {
    @objc dynamic var name: String = ""
    @objc dynamic var photo: NSData?
}


