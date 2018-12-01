//
//  ViewController.swift
//  demo
//
//  Created by Imobtree Solutions on 3/14/18.
//  Copyright © 2018 Imobtree Solutions. All rights reserved.
//

import UIKit
import RealmSwift
let realm = try! Realm()


class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var profileTable: UITableView!
    
    var allProfile : Results<Profile>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        allProfile = realm.objects(Profile.self)
        profileTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProfile.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ProfileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        
        let profile = allProfile[indexPath.row]
        if profile.photo != nil {
            let imagePt = UIImage(data: (profile.photo as! NSData) as Data)
            cell.profileImage.image = imagePt
        }
        cell.profileName.text = profile.name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let updateData = allProfile[indexPath.row]
        
        let alertController : UIAlertController = UIAlertController(title: "New Todo", message: "What do you plan to do?", preferredStyle: .alert)
        
        alertController.addTextField { (UITextField) in
        }
        let action_cancel = UIAlertAction.init(title: "Cancel", style: .cancel) { (UIAlertAction) -> Void in
        }
        alertController.addAction(action_cancel)
        let action_add = UIAlertAction.init(title: "Add", style: .default) { (UIAlertAction) -> Void in
            try! realm.write {
                updateData.name = alertController.textFields![0].text!
            }
            self.profileTable .reloadData()
        }
        alertController.addAction(action_add)
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        let deleteObj = allProfile[indexPath.row]
        if editingStyle == .delete
        {
            try! realm.write {
                realm.delete(deleteObj)
                self.profileTable.reloadData()
            }
        }
    }
}

