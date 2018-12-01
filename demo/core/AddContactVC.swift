//
//  AddContactVC.swift
//  CoreData
//
//  Created by ravi-macmini on 29/11/18.
//  Copyright © 2018 milan-macmini. All rights reserved.
//

import UIKit
import CoreData

class AddContactVC: UIViewController {
    
    var isEdit: Bool = Bool()
    var name:String = String()
    var number:String = String()
    var index:Int = Int()
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if isEdit == true {
            txtName.text = name
            txtNumber.text = number
        }
    }

    @IBAction func btnSaveClick(_ sender: Any) {
        let dict = ["name":txtName.text,"number":txtNumber.text]
        if isEdit == true {
            DatabaseHelper.sharedInstance.editData(object: dict as! [String : String], i: index)
        } else {
            DatabaseHelper.sharedInstance.save(object: dict as! [String : String])

        }
    }
    

}
