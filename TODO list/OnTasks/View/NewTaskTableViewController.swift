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
    
    
    var task: Results<Task>!
//    let presenter: NewTaskPresenter!
    // Date formater
    
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
            if tsk.isComplete == false {
                tasks.append(tsk)
            }
        }
        return tasks
    }
    // MARK: Override funcs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        
        task = realm.objects(Task.self)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()

    }
    
    // MARK: TableView add
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tasks = isCompleteRevers()
        return tasks.isEmpty ? 0 : tasks.count //
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
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
    
    // MARK: TableView remove cell
    
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
                task.isComplete = true
                task.dueDate = Date.init()
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
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
    
    @IBAction func SortSelection(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            task = task.sorted(byKeyPath: "date")
        } else {
            task = task.sorted(byKeyPath: "name")
        }
        tableView.reloadData()
    }
    
    
    // MARK: Navigaton
    
    @IBAction func unwind (segue: UIStoryboardSegue) {
        
        guard let creatTaskVC = segue.source as? CreateTaskViewController else {return}
        creatTaskVC.presenter.saveTask()
        creatTaskVC.presenter.loadTask()
        let task = creatTaskVC.task
        let imageData = creatTaskVC.presenter.imageDataConvert()
        if creatTaskVC.presenter.currentTask != nil{
            try! realm.write{
                creatTaskVC.presenter.currentTask.name = creatTaskVC.nameTaskTextField.text
                creatTaskVC.presenter.currentTask.descriptionTask = creatTaskVC.descriptionTextView.text
                creatTaskVC.presenter.currentTask.imageDat = imageData
            }
        } else {
            StorageManager.saveObject(task)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let tasks = isCompleteRevers()
            let task = tasks[indexPath.row] //
            let creatVC = segue.destination as! CreateTaskViewController
            creatVC.currentTask = task
            
        }
    }
    
    
    
}


extension NewTaskTableViewController {}




