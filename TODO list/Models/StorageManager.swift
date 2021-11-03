//
//  StorageManager.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 02.11.2021.
//

import RealmSwift

let realm = try! Realm()


class StorageManager {
    
    static func saveObject(_ task: Task){
        try! realm.write {
            realm.add(task)
        }
    }
    
    static func deleteObject(_ task: Task){
        try! realm.write {
            realm.delete(task)
        }
    }
    
    
}
