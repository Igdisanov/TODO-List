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
            guard let login = registrationView?.getLogin(), login == loginTest.login
            else {return registrationView.showErrorMessage(message: "Login or password is not corrent")}
            guard let password = registrationView?.getPassword(), password == loginTest.password
            else {return registrationView.showErrorMessage(message: "Login or password is not corrent")}
            registrationView.routeNewTasks()
            saveLoginTest(login: login, Password: password)
            print(login)
        } else {
            registrationView.showErrorMessage(message: "Enter yuo login and password")
        }
    }
    
    
    func saveLoginTest(login: String, Password: String){
        let login = LoginDAO(login: login, password: Password)
        registrationModel?.saveLogin(loginDAO: login)
        print("\(login.login)")
    }
    
    func loginOnData(){
        if let loginTest = registrationModel?.loadLogin(), loginTest.login?.isEmpty == false{
            registrationView.routeNewTasks()
        }
    }
    
}
