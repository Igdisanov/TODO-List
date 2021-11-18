//
//  CreateTaskPresenter.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 12.11.2021.
//

import Foundation


class CreatePresenter {
    weak var createView: CreateViewProtocole!
    var createModel: CreateSaveProtocol!
    func setCreatView(createView: CreateViewProtocole){
        self.createView = createView
    }
    func setCreatModel(createModel: CreateSaveProtocol){
        self.createModel = createModel
    }
    
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
    
    

}
