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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(sender: AnyObject) {
        
        APIClient.sharedInstance().login(emailField.text!, password: passwordField.text!) { (success, error) in
                print(success)
                dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                    self.loginButton.enabled = success
            }
        
        }
    }

    @IBAction func launchSignUp(sender: AnyObject) {
        let openLink = NSURL(string : "https://www.udacity.com/account/auth#!/signin")
        UIApplication.sharedApplication().openURL(openLink!)
    }
}

