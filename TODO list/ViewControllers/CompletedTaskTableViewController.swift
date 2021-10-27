//
//  CompletedTaskTableViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit



class CompletedTaskTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var taskList: TaskList!
    let dictionaryTrue = ["task": TaskList()]
    
    var formater: String {
        get {
            let formater = DateFormatter()
            formater.dateStyle = .medium
            return formater.string(from: Date.init())
        }
    }
    
    
    
    // MARK: Override funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
       
        navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(gotNotification), name: NSNotification.Name(rawValue: "notoficationFromFirstViewController"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
        }
    
    
    // MARK: Notification
    
    @objc func gotNotification(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        guard let taskList = userInfo["task"] as? Task else {return}
        self.taskList.trueTaskList.append(taskList)
    }
    
    
    // MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let taskList = taskList.trueTaskList
        return taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedSell", for: indexPath)
        let taskList = taskList.trueTaskList

        let task = taskList[indexPath.row]
        cell.textLabel?.text = task.name
        
        cell.detailTextLabel?.text = formater
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            taskList.trueTaskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: TableView post cell
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    func doneAction(indexPath: IndexPath) -> UIContextualAction {
        
        var tL = taskList.trueTaskList[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Ok") { [self] (action, view, completion) in
            
            
            tL.isComplete = !tL.isComplete!
            if tL.isComplete == false {
                self.taskList.trueTaskList.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notoficationFromLastViewController"), object: nil, userInfo: ["task": tL])
               
            }
            
            completion(true)
        }
        action.backgroundColor = .orange
        action.image = UIImage(systemName: "arrowshape.turn.up.backward.2")
        return action
    }
    
    
    
}


