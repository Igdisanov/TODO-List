//
//  RegistrationPresenter.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 12.11.2021.
//

import Foundation

class RegistrationPresenter {
    
    weak var registrationView: RegistrationViewProtocol!
    weak var registrationModel: RegistrationRepoProtocol!
    
   func setRegistrationView(registrationView: RegistrationViewProtocol){
        self.registrationView = registrationView
    }
    
    let loginTest = LoginDAO(login: "test", password: "123")
    
    func verifyData(){
        
        if registrationView.getLogin().isEmpty == false{
            guard let login = registrationView?.getLogin(), login == loginTest.login, let password = registrationView?.getPassword(), password == loginTest.password
            else {return registrationView.showErrorMessage(message: "Login or password is not corrent")}
            
            registrationView.routeNewTasks()
            UserDefaults.standard.set(login, forKey: "login")
        } else {
            registrationView.showErrorMessage(message: "Enter yuo login and password")
        }
    }
    
    
    
    
    func loginOnData(){
        if let loginTest = UserDefaults.standard.string(forKey: "login"), loginTest.isEmpty == false{
            registrationView.routeNewTasks()
            print(loginTest)
        } else {
            print("ne vipolneno")
        }
    }
    
}
