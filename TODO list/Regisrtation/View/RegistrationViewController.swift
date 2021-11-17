//
//  RegistrationViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 09.11.2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    var presenter: RegistrationPresenter!

    
    @IBOutlet weak var loginTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RegistrationPresenter()
        presenter.setRegistrationView(registrationView: self)
        errorLabel.isHidden = true
        print("didload")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loginOnData()
      print("willApper")
    }

    @IBAction func loginButtomPressed(_ sender: Any) {
        presenter.verifyData()
        
    }
    
    @IBAction func registrationButtomPressed(_ sender: Any) {
        
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        loginTextView.text = nil
        passwordTextView.text = nil
        errorLabel.isHidden = true
        UserDefaults.standard.removeObject(forKey: "login")
    }
    
}




extension RegistrationViewController: RegistrationViewProtocol {
    
    func getLogin() -> String {
        return loginTextView.text!
    }
    
    func getPassword() -> String {
        return passwordTextView.text!
    }
    
    func routeNewTasks() {
            performSegue(withIdentifier: "registrationSegue", sender: nil)
        
    }
    
    func showErrorMessage(message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
    }
    
    
    
    
}
