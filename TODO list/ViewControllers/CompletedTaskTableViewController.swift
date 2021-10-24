//
//  CompletedTaskTableViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit

class CompletedTaskTableViewController: UITableViewController {
    
    var trueTaskList: [Task] = []
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        navigationItem.hidesBackButton = true
        

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        trueTaskList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedSell", for: indexPath)
        let task = trueTaskList[indexPath.row]
        
        cell.textLabel?.text = task.name
        
        
        return cell
    }

}

