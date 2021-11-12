//
//  CompletedTaskTableViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit
import RealmSwift


class CompletedTaskTableViewController: UITableViewController {
    
    // MARK: Properties
    
    
    var task: Results<Task>!
    
    var formater: String {
        get {
            let formater = DateFormatter()
            formater.dateStyle = .medium
            return formater.string(from: Date.init())
        }
    }
    
    private func isCompleteRevers() -> [Task] {
        var tasks: [Task] = []
        
        for tsk in task {
            if tsk.isComplete == true {
                tasks.append(tsk)
            }
        }
        return tasks
    }
    
    // MARK: Override funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        task = realm.objects(Task.self)
        task = task.sorted(byKeyPath: "dueDate")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    // MARK: TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tasks = isCompleteRevers()
        return tasks.isEmpty ? 0 : tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedSell", for: indexPath) as! CustomComletedTableViewCell
        let tasks = isCompleteRevers()
       
        
        let task = tasks[indexPath.row] //
        let startImage = UIImage(named: "396619-200")
        let startImageData = startImage?.pngData()
        cell.nameLabel.text = task.name
        cell.dateLabel.text = formater
        cell.imageViewCell.image = UIImage(data: (task.imageDat ?? startImageData)!)
        cell.imageViewCell.layer.cornerRadius = 10
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let tasks = isCompleteRevers()
        let task = tasks[indexPath.row] //
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
        
        let tasks = isCompleteRevers()
        
        let task = tasks[indexPath.row] //
        let action = UIContextualAction(style: .normal, title: "Ok") { [self] (action, view, completion) in
            
            try! realm.write {
                task.isComplete = false
            }
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completion(true)
        }
        action.backgroundColor = .orange
        action.image = UIImage(systemName: "arrowshape.turn.up.backward.2")
        return action
    }
    
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            task = task.sorted(byKeyPath: "dueDate")
        } else {
            task = task.sorted(byKeyPath: "name")
        }
        tableView.reloadData()
    }
    
    
}


