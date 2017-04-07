//
//  ItemCell.swift
//  DreamLister
//
//  Created by Bryan Fein on 4/6/17.
//  Copyright © 2017 Bryan Fein. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {


    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDecription: UILabel!
    
    func configureCell(item : Item)  {
        
        title.text = item.title
        itemPrice.text = "$\(item.price)"
        itemDecription.text = item.details
    }
    
}
