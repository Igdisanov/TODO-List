//
//  StartViewController.swift
//  TODO list
//
//  Created by Vadim Igdisanov on 27.10.2021.
//

import UIKit

class StartViewController: UIViewController {

    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let tabBarVC = segue.destination as? NavigationTabBarViewController else {return}
        guard let navigationFirstVC = tabBarVC.viewControllers?.first as? UINavigationController else {return}
        guard let navigationSecondVC = tabBarVC.viewControllers?.last as? UINavigationController else {return}
        guard let newTaskVC = navigationFirstVC.topViewController as? NewTaskTableViewController else {return}
        guard let completedVC = navigationSecondVC.topViewController as? CompletedTaskTableViewController else {return}

        newTaskVC.taskListC = TaskList()
        completedVC.trueTaskList = TaskList()
    }
    
    
    // MARK: IBActions
    
    @IBAction func startButtonPrassed() {
        performSegue(withIdentifier: "startSegue", sender: nil)
    }
    
    

}
