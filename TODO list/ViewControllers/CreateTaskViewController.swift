//
//  ViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit
import RealmSwift


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
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        nameTaskTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    
    @objc private func textFieldChanged() {
        if nameTaskTextField.text?.isEmpty == false {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
   
    
}
