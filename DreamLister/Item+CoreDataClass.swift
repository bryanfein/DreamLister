//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Bryan Fein on 4/5/17.
//  Copyright © 2017 Bryan Fein. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {

    
    //anytime this item gets inserted in the NSManaged object context // when you create this item from the enitity this function will be called.
    
    public override func awakeFromInsert() {
        
        //call the super class
        super.awakeFromInsert()
        
        // assign the NSDate to the atribute created
        self.created = NSDate()
    }
    
}
