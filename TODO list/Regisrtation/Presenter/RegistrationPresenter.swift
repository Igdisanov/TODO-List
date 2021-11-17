//
//  RegistrationPresenter.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 12.11.2021.
//

import Foundation

class RegistrationPresenter {
    
    
    weak var registrationView: RegistrationViewProtocol!
    var registrationModel: RegistrationRepoProtocol!
    
    init(){}
    
    init(pegistrationRepoProtocol: RegistrationRepoProtocol){
        self.registrationModel = pegistrationRepoProtocol
    }
    
    
    func setRegistretionModel(registrationModel: RegistrationRepoProtocol){
        self.registrationModel = registrationModel
    }
    
    func setRegistrationView(registrationView: RegistrationViewProtocol){
        self.registrationView = registrationView
    }
    
    
    
    
    let loginTest = LoginDAO(login: "test", password: "123")
    
    func verifyData(){
        
        if registrationView.getLogin().isEmpty == false{
            guard let login = registrationView?.getLogin(), login == loginTest.login, let password = registrationView?.getPassword(), password == loginTest.password
            else {return registrationView.showErrorMessage(message: "Login or password is not corrent")}
            
            registrationView.routeNewTasks()
            registrationModel.saveLogin(login: login, password: password)
//            UserDefaults.standard.set(login, forKey: "login")
        } else {
            registrationView.showErrorMessage(message: "Enter yuo login and password")
        }
    }
    
    
    
    
    func loginOnData(){
        if let loginTest = registrationModel?.loadLogin(), loginTest.login?.isEmpty == false{
            registrationView.routeNewTasks()
        } else {
            print("ne vipolneno")
        }
    }
    
}
