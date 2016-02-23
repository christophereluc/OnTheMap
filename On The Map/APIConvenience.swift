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
    
    func loginAndRetrieveStudentLocations(username: String, password: String, completionHandlerForResult: (success: Bool, error: NSError?) -> Void) {
        login(username, password: password) {
            (success, error) in
            if success {
                self.retrieveStudentLocations() {
                    (success, error) in
                    if success {
                        completionHandlerForResult(success: true, error: nil)
                    }
                    else {
                        completionHandlerForResult(success: false, error: error)
                    }
                }
            }
            else {
                completionHandlerForResult(success: false, error: error)
            }
        }
    }
    
    func login(username: String, password: String, completionHandlerForResult: (success: Bool, error: NSError?) -> Void) {
        let parameters = [String:NSObject]()
        let jsonBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        taskForPOSTMethod(udacity, method: Methods.Session, parameters: parameters, jsonBody: jsonBody) {
            (result, error) in
            if let error = error {
                completionHandlerForResult(success: false, error: error)
            }
            else {
                completionHandlerForResult(success: true, error: nil)
            }
        }
    }
    
    
    //Retrieves student info
    func retrieveStudentLocations(completionHandlerForResults: (success: Bool, error: NSError?) -> Void) {
        let parameters = [
            ParameterKeys.Limit: ParameterValues.Limit,
            ParameterKeys.Order: ParameterValues.UpdatedAt
        ]
        taskForGETMethod(parse, method: Methods.ParseStudentLocation, parameters: parameters) {
            (result, error) in
            
            if let error = error {
                completionHandlerForResults(success: false, error: error);
            }
            else if let result = result[JSONResponseKeys.Results] as? [[String:AnyObject]] {
                self.studentData = StudentInfo.studentInfoFromResults(result)
                completionHandlerForResults(success: true, error: nil)
            }
            else {
                completionHandlerForResults(success: false, error: error);
            }
        }

    }
}