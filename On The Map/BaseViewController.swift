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
    
    let reuseIdentifier = "studentInfo"
    
    //Dismisses the VC and returns to the homescreen
    func logout() {
        APIClient.sharedInstance().logout(nil)
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
                self.dataRetrieved()
            }
            else {
                let alertController = UIAlertController(title: nil, message: "Error download student data", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
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