//
//  Task.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import RealmSwift
import Foundation

class Task: Object {
    
    @objc dynamic  var name: String?
    @objc dynamic var descriptionTask: String?
    @objc dynamic var date: Date?
    @objc dynamic var isComplete: Bool = false
    
    convenience init(name: String, descriptionTask: String, date: Date?, isComplete: Bool ){
        self.init()
        self.name = name
        self.descriptionTask = descriptionTask
        self.date = date
        self.isComplete = isComplete
    }
}

class FalseTask: Task {
    
}

class TrueTask: Task {
    
}


