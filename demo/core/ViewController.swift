//
//  ViewController.swift
//  CoreData
//
//  Created by ravi-macmini on 29/11/18.
//  Copyright © 2018 milan-macmini. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tblView: UITableView!
    var contact = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contact = DatabaseHelper.sharedInstance.getData()
        self.tblView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnAddPressed(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "AddContactVC") as! AddContactVC
        VC.isEdit = false
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        cell.lblName.text = contact[indexPath.row].name
        cell.lblNumber.text = contact[indexPath.row].number
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contact = DatabaseHelper.sharedInstance.deleteData(index: indexPath.row)
            self.tblView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "AddContactVC") as! AddContactVC
        VC.isEdit = true
        VC.name = contact[indexPath.row].name!
        VC.number = contact[indexPath.row].number!
        VC.index = indexPath.row
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

