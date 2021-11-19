//
//  CreateTaskPresenter.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 12.11.2021.
//

import Foundation


class CreatePresenter {
    
    
    var currentTask: Task!
    
    // MARK: propertys MVP
    weak var createView: CreateViewProtocole!
    var createModel: CreateSaveProtocol!
    
    // MARK: methods MVP
    func setCreatView(createView: CreateViewProtocole){
        self.createView = createView
    }
    func setCreatModel(createModel: CreateSaveProtocol){
        self.createModel = createModel
    }
    
    // MARK: save and load task
    func imageDataConvert() -> Data? {
        guard let image = createView?.getimageViewAdd() else {return nil}
        let imageData = image.pngData()
        return imageData
    }
    
    func saveTask(){
        createModel.saveTasks(name: createView.getnameTaskTextField(),
                              descriptionTask: createView.getdescriptionTextView(),
                              date: createView.getDate(),
                              isComplete: false,
                              imageData: imageDataConvert())
    }
    
    func loadTask(){
        if let task = createModel?.loadTask(), task.name?.isEmpty == false{
            createView.loadTask(task: task)
        }
    }
    
    func getTask(){
        guard let task = createView?.getTask(), task.name?.isEmpty == false else {return}
        self.currentTask = task
    }
    

}
