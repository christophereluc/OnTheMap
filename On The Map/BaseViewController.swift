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
    let reuseIdentifier = "studentInfo"
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Retrieve data from API client
        studentData = APIClient.sharedInstance().studentData
    }
    
    //Dismisses the VC and returns to the homescreen
    func logout() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Empty function; should be overriden by subclass
    //Called once API client returns success
    func dataRetrieved() {
        
    }
    
    //Directly calls retrieveStudentLocations to refresh data from API
    func fetchData() {
        APIClient.sharedInstance().retrieveStudentLocations() {
            (success, error) in
            if success {
                self.studentData = APIClient.sharedInstance().studentData
                self.dataRetrieved()
            }
        }
    }
    
    //Used to launch a link
    func launchLink(link: String) {
        let openLink = NSURL(string : link)
        if let link = openLink {
            UIApplication.sharedApplication().openURL(link)
        }
        else {
            let alert = UIAlertController(title: "Error", message: "URL was invalid", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(ok)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
}