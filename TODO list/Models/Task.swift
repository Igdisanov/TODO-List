//
//  Task.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 24.10.2021.
//

import RealmSwift

struct Task {
    
    var name: String?
    var descriptionTask: String?
    var date: Date?
    var isComplete: Bool?
    
}


struct TaskList {
    
    var falseTaskList: [Task] = []
    
    var trueTaskList: [Task] = []
    
}

