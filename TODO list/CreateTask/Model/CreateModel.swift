//
//  CreateModel.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 18.11.2021.
//

import Foundation

class CreateModel: CreateSaveProtocol {
    
    var task = Task()
    
    func saveTasks(name: String, descriptionTask: String, date: Date, isComplete: Bool, imageData: Data?){
        task  = Task(
            name: name,
            descriptionTask: descriptionTask,
            date: date,
            isComplete: isComplete,
            imageData: imageData
        )
    }
    
    func loadTask() -> Task {
        task
    }
    
}
