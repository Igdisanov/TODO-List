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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = CreatePresenter()
        presenter.setCreatView(createView: self)
        createSaveProtocol = CreateModel()
        presenter.setCreatModel(createModel: createSaveProtocol)
        presenter.getTask()
        
        descriptionTextViewStylization()
        presenter.setupEditScreen()
        hideBarButtomItem()
        nameTaskTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        imageViewAdd.layer.cornerRadius = 10
        navigationItem.rightBarButtonItem?.isEnabled = false
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
        if presenter.currentTask != nil {
            try! realm.write{
                presenter.currentTask.imageDat = nil
            }
            imageViewAdd.image = UIImage(named: "396619-200")
        } else {
            imageViewAdd.image = UIImage(named: "396619-200")
            deleteImageButton.isHidden = true
        }
    }
}

