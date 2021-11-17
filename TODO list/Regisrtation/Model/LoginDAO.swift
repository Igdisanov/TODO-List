//
//  LoginDAO.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 12.11.2021.
//

import Foundation

class LoginDAO: NSObject, NSCoding {
    
    
    let login: String?
    let password: String?
    
    init(login: String?, password: String?){
        self.login = login
        self.password = password
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(login, forKey: "login")
        coder.encode(password, forKey: "password")
    }
    
    required init?(coder: NSCoder) {
        login = coder.decodeObject(forKey: "login") as? String ?? ""
        password = coder.decodeObject(forKey: "password") as? String ?? ""
    }
    
}
