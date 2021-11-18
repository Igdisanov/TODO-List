//
//  CreateModel.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 18.11.2021.
//

import Foundation
 
class CreateModel: CreateSaveProtocol {
    func saveTasks(name: String, descriptionTask: String, date: Date, isComplete: Bool, imageData: Data) -> Task {
        let task  = Task(name: name, //
                         descriptionTask: descriptionTask,
                         date: date,
                         isComplete: isComplete,
                         imageData: imageData
        )
        return task
    }
    
}
