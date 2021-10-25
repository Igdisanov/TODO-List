//
//  ViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit

protocol TaskProtocol {
    var task: Task { get }
}

class CreateTaskViewController: UIViewController, TaskProtocol {
    
    var delegate: CreateTaskViewControllerDelegate!
    
    
    var task: Task {
        let task  = Task(
            name: nameTaskTextField.text ?? "",
            descriptionTask: descriptionTextView.text ?? "",
            isComplete: false)
        
        return task
    }
    
    
    @IBOutlet var nameTaskTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.text = ""
        descriptionTextView.backgroundColor = .lightGray
        descriptionTextView.layer.cornerRadius = 10
        
        
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        delegate.saveFalseTask(task)
        print("ok")
        dismiss(animated: true)
        
    }
    
    
    
}
