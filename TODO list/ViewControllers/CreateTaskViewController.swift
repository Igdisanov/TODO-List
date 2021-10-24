//
//  ViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit

class CreateTaskViewController: UIViewController {
    
    var taskList: Task!
    
    
    @IBOutlet var nameTaskTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        descriptionTextView.text = ""
        descriptionTextView.backgroundColor = .lightGray
        descriptionTextView.layer.cornerRadius = 10
        
        
    }
    

    @IBAction func addTaskImageViewButtonPressed(_ sender: Any) {
    }
    

}
