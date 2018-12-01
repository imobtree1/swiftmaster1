//
//  Contact+CoreDataProperties.swift
//  CoreData
//
//  Created by ravi-macmini on 29/11/18.
//  Copyright © 2018 milan-macmini. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var name: String?
    @NSManaged public var number: String?

}
