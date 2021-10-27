//
//  NewTaskTableViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit


class NewTaskTableViewController: UITableViewController  {
    
    // MARK: Properties
    
    var taskListC: TaskList!
    
    var falseTaskList: [Task] = []
    var trueTaskList: [Task] = []
    
    
    
    // MARK: Override funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
 
    
    // MARK: TableView add
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let taskList = taskListC.falseTaskList
        
        return taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let taskList = taskListC.falseTaskList

        let task = taskList[indexPath.row]
        cell.textLabel?.text = task.name
        
        cell.detailTextLabel?.text = "\(Date.init())"
        
        return cell
    }
    
    
    
    // MARK: TableView cell
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            taskListC.falseTaskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    let dictionary = ["task": TaskList()]
    
    func doneAction(indexPath: IndexPath) -> UIContextualAction {
        
        var tL = taskListC.falseTaskList[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Ok") { [self] (action, view, completion) in
            
            
            tL.isComplete = !tL.isComplete!
            if tL.isComplete == false {
                self.falseTaskList[indexPath.row] = tL
            } else {
                
                self.taskListC.falseTaskList.remove(at: indexPath.row)
//                self.taskListC.trueTaskList.append(tL)
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
            let newIndexPath = IndexPath(row: taskListC.falseTaskList.count, section: 0)
            taskListC.falseTaskList.append(task)
            tableView.insertRows(at: [newIndexPath], with: .fade)

           }
    //
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let creatVC = segue.destination as? CreateTaskViewController else { return }
            guard let comletedVC = self.tabBarController?.viewControllers?.last as? CompletedTaskTableViewController else {return}
            let newIndexPath = IndexPath(row: comletedVC.trueTaskList.falseTaskList.count, section: 0)
            comletedVC.trueTaskList = taskListC
            comletedVC.tableView.insertRows(at: [newIndexPath], with: .fade)
            creatVC.taskList = taskListC
           
        }
    
    
    
    
}




