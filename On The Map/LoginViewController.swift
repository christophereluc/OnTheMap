//
//  ViewController.swift
//  On The Map
//
//  Created by Christopher Luc on 2/16/16.
//  Copyright © 2016 Christopher Luc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupText: UITextView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(sender: AnyObject) {
        
        self.loginButton.enabled = false;
        APIClient.sharedInstance().loginAndRetrieveStudentLocations(emailField.text!, password: passwordField.text!) { (success, error) in
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                if success {
                    self.emailField.text = ""
                    self.passwordField.text = ""
                    if let resultController = self.storyboard?.instantiateViewControllerWithIdentifier("TabBar") as? UITabBarController {
                        self.presentViewController(resultController, animated: true, completion: nil)
                    }
                }
                self.loginButton.enabled = true
            }
        }
    }

    @IBAction func launchSignUp(sender: AnyObject) {
        let openLink = NSURL(string : "https://www.udacity.com/account/auth#!/signin")
        UIApplication.sharedApplication().openURL(openLink!)
    }
}

