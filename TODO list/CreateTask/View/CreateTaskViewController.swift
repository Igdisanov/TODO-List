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
    var presenter: CreatePresenter!
    var createSaveProtocol: CreateSaveProtocol!
    
    @IBOutlet var nameTaskTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var addImageButton: UIButton!
    @IBOutlet var imageViewAdd: UIImageView!
    @IBOutlet var deleteImageButton: UIButton!
    
    func imageDataConvert() -> Data? {
        guard let image = imageViewAdd.image else {return nil}
        let imageData = image.pngData()
        return imageData
    }
    
    
    

        var task: Task {
    
            let imageData = imageDataConvert()
            let task  = Task(name: nameTaskTextField.text!, //
                             descriptionTask: descriptionTextView.text!,
                             date: Date.init(),
                             isComplete: false,
                             imageData: imageData!
            )
    
            return task
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = CreatePresenter()
        presenter.setCreatView(createView: self)
        createSaveProtocol = CreateModel()
        presenter.setCreatModel(createModel: createSaveProtocol)

        
        descriptionTextViewЫtylization()
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        nameTaskTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        setupEditScreen()
        
        imageViewAdd.layer.cornerRadius = 10
        deleteImageButton.layer.cornerRadius = 8
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        presenter.initTask()
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
            imageViewAdd.image = UIImage(data: currentTask.imageDat! )
            addImageButton.setTitle("Изменить изображение", for: .normal)
            
        } else {
            deleteImageButton.isHidden = true
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
    
    @IBAction func deleteImageButtonPressed(_ sender: Any) {
        if currentTask != nil {
            try! realm.write{
                currentTask.imageDat = nil
            }
            imageViewAdd.image = UIImage(named: "396619-200")
        } else {
            imageViewAdd.image = UIImage(named: "396619-200")
            deleteImageButton.isHidden = true
            
        }
    }
    
}


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
        //        imageViewAdd.layer.cornerRadius = imageViewAdd.frame.size.height / 2
        imageViewAdd.clipsToBounds = true
        deleteImageButton.isHidden = false
        addImageButton.setTitle("Изменить изображение", for: .normal)
        dismiss(animated: true)
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
    
    func loadTask(task: Task){

    }
}
