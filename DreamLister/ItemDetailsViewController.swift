//
//  ItemDetailsViewController.swift
//  DreamLister
//
//  Created by Bryan Fein on 4/7/17.
//  Copyright © 2017 Bryan Fein. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var strorePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var PriceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    
    var stores = [Store]()
    var itemToEdit : Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // "hide" the text for the backButton item
        if let topItem = self.navigationController?.navigationBar.topItem {
            
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            
        }
        
        strorePicker.delegate = self
        strorePicker.dataSource = self
        
        
        let store = Store(context: context)
        store.name = "Best Buy"
        
        let store2 = Store(context: context)
        store2.name = "Best Buy2"
        
        let store3 = Store(context: context)
        store3.name = "Best Buy3"
        
        let store4 = Store(context: context)
        store4.name = "Best Buy4"
        
        let store5 = Store(context: context)
        store5.name = "Best Buy5"
        
        let store6 = Store(context: context)
        store6.name = "Best Buy6"
        
        //save the context
        ad.saveContext()
        getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let store = stores[row]
        return store.name
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do{
            self.stores = try context.fetch(fetchRequest)
            self.strorePicker.reloadAllComponents()
        } catch {
            /// handel error
        }
    }
    
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        var item : Item!
        //updating the cell not creating a new one
    
        if itemToEdit == nil {
            
            item = Item(context: context)
            
        }else {
            item = itemToEdit
        }
        
        if let title = titleField.text {
            item.title = title
        }
        
        if let price = PriceField.text {
            
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text {
            
            item.details = details
        }
        
        item.toStore = stores[strorePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    func loadItemData(){
        
        if let item = itemToEdit {
            
            titleField.text = item.title
            PriceField.text = "\(item.price)"
            detailsField.text = item.details
            
            
            if let store = item.toStore {
                
                var index = 0
                repeat {
                    
                    let s = stores[index]
                    
                    if s.name == store.name {
                        strorePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                    
                } while (index < stores.count)
            }
        }
        
    }
    
    

    @IBAction func deleteButton(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        
        _ = navigationController?.popViewController(animated: true)
    }

    
    
}


