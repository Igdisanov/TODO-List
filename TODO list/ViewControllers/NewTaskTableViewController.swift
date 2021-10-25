//
//  NewTaskTableViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit

protocol CreateTaskViewControllerDelegate {
    func saveFalseTask (_ task: Task)
}


class NewTaskTableViewController: UITableViewController  {
    
    
    var falseTaskList: [Task] = []
    var trueTaskList: [Task] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        falseTaskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = falseTaskList[indexPath.row]
        cell.textLabel?.text = task.name
        
        cell.detailTextLabel?.text = "\(Date.init())"
        
        return cell
    }
    
    
    
    @IBAction func addTaskUIBB(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addSegue", sender: nil)
        print("go")
        
    }
    

    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            falseTaskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [done])
    }
    
//    func comletedTask() {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        guard let secondStoryBoard = storyBoard.instantiateViewController(identifier: "CompletedTaskTableViewController") as? CompletedTaskTableViewController else {return}
//        secondStoryBoard.trueTaskList = self.trueTaskList
//       show(secondStoryBoard, sender: nil)
//    }
    
    func doneAction(indexPath: IndexPath) -> UIContextualAction {
        var tL = falseTaskList[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Ok") { [self] (action, view, completion) in
            
            
            tL.isComplete = !tL.isComplete!
            if tL.isComplete == false {
                self.falseTaskList[indexPath.row] = tL
            } else {
                self.falseTaskList.remove(at: indexPath.row)
                self.trueTaskList.append(tL)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
//                comletedTask()
                print("действие")
                print("\(self.falseTaskList.count)")
                print("\(self.trueTaskList.count)")
            }
           
            completion(true)
        }
        action.backgroundColor = .green
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let creatVC = segue.destination as! CreateTaskViewController
        creatVC.delegate = self
    }
    
    
    
}





extension NewTaskTableViewController: CreateTaskViewControllerDelegate  {
    func saveFalseTask(_ task: Task) {
        if task.isComplete == false {
            let newIndexPath = IndexPath(row: falseTaskList.count, section: 0)
            falseTaskList.append(task)
            tableView.insertRows(at: [newIndexPath], with: .fade)
            print(task.name ?? "arror")
            print(falseTaskList.count)
            print(trueTaskList.count)
        } else {
            trueTaskList.append(task)
        }
    }
    
    
    
    
    
    
}

