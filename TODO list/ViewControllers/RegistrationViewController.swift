//
//  RegistrationViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 09.11.2021.
//

import UIKit

class RegistrationViewController: UIViewController {

    
    @IBOutlet var loginTextView: UITextField!
    @IBOutlet var passwordTextView: UITextField!
    
    let login = ["Vadim", "Petr", "Aleksandr"]
    let password = "Password"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func loginButtomPressed(_ sender: Any) {
        for name in login {
            guard loginTextView.text == name else {return}
            guard passwordTextView.text == password else {return}
                performSegue(withIdentifier: "registrationSegue", sender: nil)
            
        }
    }
    
    @IBAction func registrationButtomPressed(_ sender: Any) {
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        loginTextView.text = nil
        passwordTextView.text = nil
    }
    
}
