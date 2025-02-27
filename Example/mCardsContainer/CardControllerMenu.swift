//
//  CardControllerMenu.swift
//  mCardsContainer_Example
//
//  Created by Alex Hmelevski on 2019-09-05.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

final class CardControllerMenu: UITableViewController {
    
    
    let items = ["Footwear", "Handbags", "Accessories"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .red
    
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 35)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
    }
}

