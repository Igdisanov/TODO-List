//
//  ViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit


class CreateTaskViewController: UIViewController {
    

    var taskList: TaskList!
    
    @IBOutlet var nameTaskTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    
    var task: Task {
        let task  = Task(
            name: nameTaskTextField.text ?? "",
            descriptionTask: descriptionTextView.text ?? "",
            isComplete: false)

        return task
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        descriptionTextView.text = ""
        descriptionTextView.backgroundColor = .lightGray
        descriptionTextView.layer.cornerRadius = 10
    }
    
   
    
    
}
