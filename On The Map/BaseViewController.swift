//
//  BaseViewController.swift
//  On The Map
//
//  Created by Christopher Luc on 2/17/16.
//  Copyright © 2016 Christopher Luc. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController : UIViewController, UINavigationBarDelegate {
    
    var studentData:[StudentInfo] = []
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
   
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
    
    func logout() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Empty function; should be overriden by subclass
    func dataRetrieved() {
        
    }
    
    //Fetches data from API
    func fetchData() {
        APIClient.sharedInstance().retrieveStudentLocations() {
            (result, error) in
            if let error = error {
                print(error)
            }
            else if let result = result {
                self.studentData = result
                self.dataRetrieved()
            }
        }
    }
}