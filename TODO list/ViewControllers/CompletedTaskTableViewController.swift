//
//  CompletedTaskTableViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit



class CompletedTaskTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var trueTaskList: TaskList!
    
    
    // MARK: Override funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        navigationItem.hidesBackButton = true
        NotificationCenter.default.addObserver(self, selector: #selector(gotNotification), name: NSNotification.Name(rawValue: "notoficationFromFirstViewController"), object: nil)
        
    }
    
    @objc func gotNotification(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        guard let taskList = userInfo["task"] as? Task else {return}
        trueTaskList.trueTaskList.append(taskList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
        }
    
    
    // MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let taskList = trueTaskList.trueTaskList
        return taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedSell", for: indexPath)
        let taskList = trueTaskList.trueTaskList

        let task = taskList[indexPath.row]
        cell.textLabel?.text = task.name
        
        cell.detailTextLabel?.text = "\(Date.init())"
        
        return cell
    }
    
    
}


