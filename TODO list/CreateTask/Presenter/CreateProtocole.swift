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
   
    func loadTask(task: Task)
}


protocol CreateSaveProtocol {
    func saveTasks(name: String, descriptionTask: String, date: Date, isComplete: Bool, imageData: Data) -> Task
}
