//
//  CreateProtocole.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 18.11.2021.
//

import Foundation
import UIKit


protocol CreateViewProtocole: AnyObject{
    func getnameTaskTextField() -> String
    func getdescriptionTextView() -> String
    func getimageViewAdd() -> UIImage
    func getDate() -> Date
    func getTask() -> Task
   
 
    
    func setupEditScreen(title: String, name: String?, description: String?, isEnable: Bool, image: Data, settitle: String, isHidden: Bool)
}


protocol CreateSaveProtocol {
    func saveTasks(name: String, descriptionTask: String, date: Date, isComplete: Bool, imageData: Data?)
    func loadTask() -> Task
}
