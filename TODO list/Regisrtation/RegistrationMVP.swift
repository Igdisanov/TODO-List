//
//  RegistrationMVP.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 12.11.2021.
//

import Foundation


protocol RegistrationRepoProtocol: AnyObject {
    func saveLogin(loginDAO: LoginDAO)
    func loadLogin() -> LoginDAO
}


protocol RegistrationViewProtocol: AnyObject {

    func getLogin()-> String
    func getPassword()-> String
    func routeNewTasks() // переход на другой viewController
    func showErrorMessage(message: String)
}



class RegistrationModel: RegistrationRepoProtocol {
    
    var presenter: RegistrationPresenter!
    let preferenses = UserDefaults.standard
    
    func saveLogin(loginDAO: LoginDAO) {
        preferenses.set(loginDAO.login, forKey: "Login")
        preferenses.set(loginDAO.password, forKey: "Password")
    }
    
    func loadLogin() -> LoginDAO {
       let login = preferenses.string(forKey: "Login")
        let  password = preferenses.string(forKey: "Password")
        
        return LoginDAO(login: login, password: password)
    }
    
    
}
