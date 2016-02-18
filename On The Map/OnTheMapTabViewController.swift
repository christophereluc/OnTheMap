//
//  OnTheMapTabViewController.swift
//  On The Map
//
//  Created by Christopher Luc on 2/17/16.
//  Copyright © 2016 Christopher Luc. All rights reserved.
//

import Foundation
import UIKit

class OnTheMapTabViewController : UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        let item1 = TabBarItemViewController()
        let icon1 = UITabBarItem(title: "Title", image: UIImage(named: "Map"), tag: 1)
        item1.tabBarItem = icon1
        let item2 = TabBarItemViewController()
        let icon2 = UITabBarItem(title: "List", image: UIImage(named: "List"), tag: 2)
        item2.tabBarItem = icon2
        let controllers = [item1, item2]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
    }
    
    //Delegate methods
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title) ?")
        return true;
    }
}
