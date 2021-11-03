//
//  StartViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 27.10.2021.
//

import UIKit

class StartViewController: UIViewController {

    
    
   
    // MARK: Navigation
    
   
    
    // MARK: IBActions
    
    @IBAction func startButtonPrassed() {
        performSegue(withIdentifier: "startSegue", sender: nil)
    }
    
    

}
