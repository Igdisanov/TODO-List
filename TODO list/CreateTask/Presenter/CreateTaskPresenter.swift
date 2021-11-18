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
    
   
    

}
