//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Bryan Fein on 4/5/17.
//  Copyright © 2017 Bryan Fein. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
