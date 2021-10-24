//
//  NewTaskTableViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit

class NewTaskTableViewController: UITableViewController {

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
        
        if task.isComplete == false {
        cell.textLabel?.text = task.name
        
        if let date = task.date {
            cell.detailTextLabel?.text = "\(date))"
        }
        }
        return cell
    }
    


    @IBAction func addTaskUIBB(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addSegue", sender: nil)
        
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        guard let creatVC = segue.source as? CreateTaskViewController else {return}
        guard let taskName = creatVC.nameTaskTextField.text else {return}
        guard let descriptionText = creatVC.descriptionTextView.text else {return}
        let newIndexPath = IndexPath(row: falseTaskList.count, section: 0)
        falseTaskList.append(Task(name: taskName, descriptionTask: descriptionText, date: Date.init(), isComplete: false))
        tableView.insertRows(at: [newIndexPath], with: .fade)
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
                
//                print("\(self.trueTaskList)")
            }
           
           completion(true)
        }
        action.backgroundColor = .green
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dataSegue" {
        let completedTaskTVC = segue.destination as? CompletedTaskTableViewController
        completedTaskTVC?.trueTaskList = trueTaskList
        }
    }
    
   
}
