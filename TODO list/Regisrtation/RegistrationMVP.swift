//
//  RegistrationMVP.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 12.11.2021.
//

import Foundation


protocol RegistrationRepoProtocol: AnyObject {
    //    var loginDAO: LoginDAO! {get set}
    func saveLogin(login: String, password: String)
    func loadLogin() -> LoginDAO
    func removeLogin()
}


protocol RegistrationViewProtocol: AnyObject {
    
    func getLogin()-> String
    func getPassword()-> String
    func routeNewTasks(segue: String) // переход на другой viewController
    func showErrorMessage(message: String)
}



class RegistrationModel: RegistrationRepoProtocol {
    
    let preferenses = UserDefaults.standard
    
    
    func saveLogin(login: String, password: String) {
        
        preferenses.set(login, forKey: "login")
        preferenses.set(password, forKey: "password")
    }
    
    func loadLogin() -> LoginDAO {
        let login = preferenses.string(forKey: "login")
        let  password = preferenses.string(forKey: "password")
        
        return LoginDAO(login: login, password: password)
    }
    
    func removeLogin() {
        preferenses.removeObject(forKey: "login")
        preferenses.removeObject(forKey: "password")
    }
    
}
