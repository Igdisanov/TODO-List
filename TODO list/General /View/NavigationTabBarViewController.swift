//
//  NavigationTabBarViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 26.10.2021.
//

import UIKit

class NavigationTabBarViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
}
