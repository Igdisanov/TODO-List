//
//  RegistrationViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 09.11.2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    var presenter: RegistrationPresenter!
    var registrationModel: RegistrationRepoProtocol!

    
    @IBOutlet weak var loginTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RegistrationPresenter()
        presenter.setRegistrationView(registrationView: self)
        
        registrationModel = RegistrationModel()
        presenter.setRegistretionModel(registrationModel: registrationModel)
        
        errorLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.loginOnData()
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
        presenter.removeLogin()
    }
    
}




extension RegistrationViewController: RegistrationViewProtocol {
   
    
    
    func getLogin() -> String {
        return loginTextView.text!
    }
    
    func getPassword() -> String {
        return passwordTextView.text!
    }
    
    func routeNewTasks(segue: String) {
            performSegue(withIdentifier: segue, sender: nil)
        
    }
    
    func showErrorMessage(message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
    }
    
    
    
    
}
