//
//  RegistrationMVP.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 12.11.2021.
//

import Foundation


protocol RegistrationModelProtocol {
    func saveLogin(loginDAO: LoginDAO)
    func loadLogin() -> LoginDAO
}


protocol RegistrationViewProtocol: AnyObject {
    func getLogin()-> String
    func getPassword()-> String
}

protocol RegistrationPresenterProtocol {
    func onLogin()
    func setView(registrationViewProtocol: RegistrationViewProtocol )
}
