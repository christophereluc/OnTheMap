//
//  APIConvenience.swift
//  On The Map
//
//  Created by Christopher Luc on 2/17/16.
//  Copyright © 2016 Christopher Luc. All rights reserved.
//

import Foundation
import UIKit

extension APIClient {
    
    func login(username: String, password: String, completionHandlerForResult: (success: Bool, error: NSError?) -> Void) {
        let parameters = [String:NSObject]()
        let jsonBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        taskForPOSTMethod(Methods.Session, parameters: parameters, jsonBody: jsonBody) {
            (result, error) in
            if let error = error {
                completionHandlerForResult(success: false, error: error)
            }
            else {
                completionHandlerForResult(success: true, error: nil)
            }
        }
    }
    
   
}