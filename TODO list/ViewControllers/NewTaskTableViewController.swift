//
//  NewTaskTableViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit
import RealmSwift

class NewTaskTableViewController: UITableViewController  {
    
    // MARK: Properties
    
    var falseTask: Results<FalseTask>!
    
    // Date formater
    
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
        
        falseTask = realm.objects(FalseTask.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: TableView add
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return falseTask.isEmpty ? 0 : falseTask.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let task = falseTask[indexPath.row]
        cell.textLabel?.text = task.name
        cell.detailTextLabel?.text = formater
        
        return cell
    }
    
    // MARK: TableView remove cell
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = falseTask[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            StorageManager.deleteObject(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: TableView post cell
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    func doneAction(indexPath: IndexPath) -> UIContextualAction {
        
        let task = falseTask[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Ok") { [self] (action, view, completion) in
            
            try! realm.write {
                task.isComplete = true
            }
            
            if task.isComplete != false {
                
                
                StorageManager.saveObject(TrueTask(name: task.name!,
                                                   descriptionTask: task.descriptionTask!,
                                                   date: task.date,
                                                   isComplete: task.isComplete))
                
                StorageManager.deleteObject(task)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
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
    }
    
    
    
    // MARK: Navigaton
    
    @IBAction func unwind (segue: UIStoryboardSegue) {
        
        guard let creatTaskVC = segue.source as? CreateTaskViewController else {return}
        let task = creatTaskVC.task
        
        if creatTaskVC.currentTask != nil{
            try! realm.write{
                creatTaskVC.currentTask.name = creatTaskVC.nameTaskTextField.text
                creatTaskVC.currentTask.descriptionTask = creatTaskVC.descriptionTextView.text
            }
        } else {
            StorageManager.saveObject(task)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let task = falseTask[indexPath.row]
            let creatVC = segue.destination as! CreateTaskViewController
            creatVC.currentTask = task
        }
    }
    
    
    
}




