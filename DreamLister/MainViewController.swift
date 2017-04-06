//
//  MainViewController.swift
//  DreamLister
//
//  Created by Bryan Fein on 4/5/17.
//  Copyright © 2017 Bryan Fein. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make sure you set your delegates in the viewDidLoad
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    //make sure you add the required methods for UITableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
}

