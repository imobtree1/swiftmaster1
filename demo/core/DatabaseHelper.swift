//
//  DatabaseHelper.swift
//  CoreData
//
//  Created by ravi-macmini on 29/11/18.
//  Copyright © 2018 milan-macmini. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class  DatabaseHelper {
    
    static var sharedInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    func save(object:[String : String]) {
        let contact = NSEntityDescription.insertNewObject(forEntityName:"Contact",into: context!) as! Contact
        contact.name = object["name"]
        contact.number = object["number"]
        do {
            try context?.save()
        } catch {
            print("data not save")
        }
    }
    
    func getData() ->[Contact] {
        var contact = [Contact]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"Contact")
        do {
            contact = try context?.fetch(fetchRequest) as! [Contact]
        } catch {
            print("cant get data")
        }
        return contact
    }
    
    func deleteData(index:Int) -> [Contact] {
        var contact = getData()

        context?.delete(contact[index])
        contact.remove(at: index)
        do {
            try context?.save()
        } catch {
            print("cant delete data")
        }
        return contact
    }
    
    func editData(object:[String : String], i:Int) {
        var contact = getData()
        contact[i].name = object["name"]
        contact[i].number = object["number"]
        do {
            try context?.save()
        } catch {
            print("data is not edit")
        }

        
    }
}
