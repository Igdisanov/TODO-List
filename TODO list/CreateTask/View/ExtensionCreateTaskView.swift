//
//  ExtensionCreateTaskView.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 19.11.2021.
//

import Foundation
import UIKit

extension CreateTaskViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicket(source: UIImagePickerController.SourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(source){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageViewAdd.image = info[.editedImage] as? UIImage
        imageViewAdd.contentMode = .scaleAspectFit
        imageViewAdd.clipsToBounds = true
        deleteImageButton.isHidden = false
        addImageButton.setTitle("Изменить изображение", for: .normal)
        dismiss(animated: true)
    }
    
}




// MARK: changing screen elements
extension CreateTaskViewController{
    
    
    // MARK: Hide name barButtonItem
    func hideBarButtomItem(){
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    // MARK: Of buttom save
    @objc func textFieldChanged() {
        if nameTaskTextField.text?.isEmpty == false {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    // MARK: Delete barButtonItem
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: Stylization descriptionTextView
     func descriptionTextViewStylization() {
        descriptionTextView.text = ""
        descriptionTextView.backgroundColor = .lightGray
        descriptionTextView.layer.cornerRadius = 10
        deleteImageButton.isHidden = true
    }
}



extension CreateTaskViewController: CreateViewProtocole {
    
    
    
    func getnameTaskTextField() -> String {
        nameTaskTextField.text!
    }
    func getdescriptionTextView() -> String{
        descriptionTextView.text!
    }
    
    func getimageViewAdd() -> UIImage{
        imageViewAdd.image!
    }
    
    func getDate() -> Date {
        Date.init()
    }
    
    func getTask() -> Task {
        guard let task = currentTask, task.name?.isEmpty == false else {return Task()}
        return task
    }
    
    func setupEditScreen(title: String, name: String?, description: String?, isEnable: Bool, image: Data, settitle: String, isHidden: Bool){
        self.title = title
        nameTaskTextField.text = name
        descriptionTextView.text = description
        navigationItem.rightBarButtonItem?.isEnabled = isEnable
        imageViewAdd.image = UIImage(data: image)
        addImageButton.setTitle(settitle, for: .normal)
        deleteImageButton.isHidden = isHidden
    }
    
    func deleteImage(image: String, isHidden: Bool){
        imageViewAdd.image = UIImage(named: image)
        deleteImageButton.isHidden = isHidden
    }
}
