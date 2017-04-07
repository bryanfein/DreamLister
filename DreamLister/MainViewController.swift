//
//  MainViewController.swift
//  DreamLister
//
//  Created by Bryan Fein on 4/5/17.
//  Copyright © 2017 Bryan Fein. All rights reserved.
//

import UIKit
import CoreData


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate {
    
    

    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    //tell the NSFRController what type we will be fetching
    var controller : NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make sure you set your delegates in the viewDidLoad
        tableView.delegate = self
        tableView.dataSource = self
        
        testData()
        attemptFetch()

        
    }
    
    //make sure you add the required methods for UITableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //create a cell and passing it into the configureCell func
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        configureCell(cell: cell, indexPath: indexPath) //as NSIndexPath
        
        return cell
        
    }
    
    func configureCell(cell : ItemCell, indexPath : IndexPath) {
        //then passing that cell into the configure cell func that we created in teh ItemCell class
        let item = controller.object(at: indexPath)
        cell.configureCell(item: item)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //grabbing the sections out of the controller
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections{
            
            return sections.count
        }
        return 0
    }
    
    //to keep the cell's height consistent we call a func call this func and return the height we want
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
    }
    
    
    // create an attamptFetch function
    func attemptFetch() {
        
        //decalre a fetchRequest variable, telling it what we will be fetching, then telling it what to go fetch
        let fetchRequest : NSFetchRequest<Item> = Item.fetchRequest()
        
        
        //"created" came from the dataModel
        //We are sorting the items based on the time stamp
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        
        fetchRequest.sortDescriptors = [dateSort]
        
        //create a controller and pass in what request we are going to pass in
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        //setting the outside controller to the inside controller
        self.controller = controller
        
        //tell the methods what to do 
       controller.delegate = self
        
        //Preform the ACTUAL fectch
        do{
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    //this func will listen for changes and do it for you
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    //this is going to listen for when theres a chnage
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type){
        //when we create an new item...
        case.insert:
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
            
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                // local method
                configureCell(cell: cell, indexPath: indexPath)
                
            }
            break
            
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
        
        
    }
    
}

func testData(){
    //created an entity item
    let item = Item(context: context)
    item.title = "New MacBook Pro"
    item.price = 1800
    item.details = "I can't wait until septmeber event, I hope they release new MacBook Pros"
    
    let item2 = Item(context: context)
    item2.title = "Bose Headphones"
    item2.price = 1800
    item2.details = "I can't wait until septmeber event, I hope they release new MacBook Pros"
    
    let item3 = Item(context: context)
    item3.title = "Ferrari"
    item3.price = 1800
    item3.details = "I can't wait until septmeber event, I hope they release new MacBook Pros"
    
    
    ad.saveContext()
}

