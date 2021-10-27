//
//  NewTaskTableViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit


class NewTaskTableViewController: UITableViewController  {
    
    // MARK: Properties
    
    var taskList: TaskList!
    let dictionaryFalse = ["task": TaskList()]
    
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
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(gtNotification), name: NSNotification.Name(rawValue: "notoficationFromLastViewController"), object: nil)
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
        }
    // MARK: Notification
    
    @objc func gtNotification(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        guard let taskList = userInfo["task"] as? Task else {return}
        self.taskList.falseTaskList.append(taskList)
    }
    
 
    
    // MARK: TableView add
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let taskList = taskList.falseTaskList
        
        return taskList.count
    }
    
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let taskList = taskList.falseTaskList

        let task = taskList[indexPath.row]
        cell.textLabel?.text = task.name
        
        cell.detailTextLabel?.text = formater
        
        return cell
    }
    
    
    
    // MARK: TableView remove cell
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            taskList.falseTaskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: TableView post cell
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    func doneAction(indexPath: IndexPath) -> UIContextualAction {
        
        var tL = taskList.falseTaskList[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Ok") { [self] (action, view, completion) in
            
            
            tL.isComplete = !tL.isComplete!
            if tL.isComplete != false {
                self.taskList.falseTaskList.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notoficationFromFirstViewController"), object: nil, userInfo: ["task": tL])
            }
            
            completion(true)
        }
        action.backgroundColor = .green
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    // MARK: IBActions
    
    @IBAction func addTaskUIBB(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addSegue", sender: nil)
        print("go")
        
    }
    
    // MARK: Navigaton
    
        @IBAction func unwind (segue: UIStoryboardSegue) {
    
            guard let creatTaskVC = segue.source as? CreateTaskViewController else {return}
            let task = creatTaskVC.task
            let newIndexPath = IndexPath(row: taskList.falseTaskList.count, section: 0)
            taskList.falseTaskList.append(task)
            tableView.insertRows(at: [newIndexPath], with: .fade)

           }
    //
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let creatVC = segue.destination as? CreateTaskViewController else { return }
            guard let comletedVC = self.tabBarController?.viewControllers?.last as? CompletedTaskTableViewController else {return}
            let newIndexPath = IndexPath(row: comletedVC.taskList.falseTaskList.count, section: 0)
            comletedVC.taskList = taskList
            comletedVC.tableView.insertRows(at: [newIndexPath], with: .fade)
            creatVC.taskList = taskList
           
        }
    
    
    
    
}




