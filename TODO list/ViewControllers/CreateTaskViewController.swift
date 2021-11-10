//
//  ViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import UIKit
import RealmSwift


class CreateTaskViewController: UIViewController {
    
    var currentTask: Task!

    @IBOutlet var nameTaskTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var imageViewAdd: UIImageView!
    
    
    var task: Task {
        let task  = Task(name: nameTaskTextField.text!, //
                         descriptionTask: descriptionTextView.text!,
                         date: Date.init(),
                         isComplete: false)
     
        return task
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        descriptionTextViewЫtylization()
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        nameTaskTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
    }
    
    // Of buttom save
    @objc private func textFieldChanged() {
        if nameTaskTextField.text?.isEmpty == false {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }

    // Delete barButtonItem
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func setupEditScreen() {
        if currentTask != nil{
            title = "Редактировать задачу"
            nameTaskTextField.text = currentTask.name
            descriptionTextView.text = currentTask.descriptionTask
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
        
    }
    
    private func descriptionTextViewЫtylization() {
        descriptionTextView.text = ""
        descriptionTextView.backgroundColor = .lightGray
        descriptionTextView.layer.cornerRadius = 10
    }
    
   
    @IBAction func addImageButtonPressed(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        
        let photo = UIAlertAction(title: "photo", style: .default) { _ in
            self.chooseImagePicket(source: .photoLibrary)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true)
    }
    
    
}


extension CreateTaskViewController {
    
    func chooseImagePicket(source: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
}
