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
    
    //Handles complete login flow (login, get user data, get data from parse)
    func loginAndRetrieveStudentLocations(username: String, password: String, completionHandlerForResult: (success: Bool, error: NSError?) -> Void) {
        login(username, password: password) {
            (success, error) in
            if success {
                self.getUserData(self.studentId!) {
                    (success, error) in
                    if success {
                        self.retrieveStudentLocations() {
                            (success, error) in
                            if success {
                                completionHandlerForResult(success: true, error: nil)
                            }
                            else {
                                completionHandlerForResult(success: false, error: NSError(domain: "Error downloading user location data", code: 1, userInfo: error?.userInfo))
                            }
                        }
                    }
                    else {
                        completionHandlerForResult(success: false, error: NSError(domain: "Error downloading user data from Udacity", code: 1, userInfo: error?.userInfo))
                    }
                }
            }
            else {
                if error?.code == 1 {
                    completionHandlerForResult(success: false, error: NSError(domain: "Invalid user name or password", code: 6, userInfo: error?.userInfo))
                }
                else {
                    completionHandlerForResult(success: false, error: NSError(domain: "Network response error when logging in", code: 1, userInfo: error?.userInfo))
                }
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
                if let account = result[JSONResponseKeys.Account] as? [String:AnyObject] {
                    if let key = account[JSONResponseKeys.Key] as? String {
                        self.studentId = key
                        completionHandlerForResult(success: true, error: nil)
                        return
                    }
                }
                completionHandlerForResult(success: false, error: error)
            }
        }
    }
    
    //Gets users's public data (for first/last name)
    func getUserData(userKey: String, completionHandlerForResult: (success: Bool, error: NSError?) -> Void) {
        let parameters = [String:NSObject]()
        let method = "\(Methods.User)/\(userKey)"
        taskForGETMethod(udacity, method: method, parameters: parameters) {
            (result, error) in
            if let error = error {
                completionHandlerForResult(success: false, error: error)
            }
            else {
                if let user = result[JSONResponseKeys.User] as? [String:AnyObject] {
                    if let firstName = user[JSONResponseKeys.UdacityFirstName] as? String, lastName = user[JSONResponseKeys.UdacityLastName] as? String {
                        self.firstName = firstName
                        self.lastName = lastName
                        completionHandlerForResult(success: true, error: nil)
                        return
                    }
                }
                completionHandlerForResult(success: false, error: error)
            }
        }
    }
    
    //Retrieves student info from Parse API
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
                StudentInfo.studentInfoFromResults(result)
                completionHandlerForResults(success: true, error: nil)
            }
            else {
                completionHandlerForResults(success: false, error: error);
            }
        }
    }
    
    //Used to post a location to parse
    func postLocation(location: String, url: String, latitude: Float, longitude: Float, completionHandlerForResults: (success: Bool, error: NSError?) -> Void ) {
        let parameters = [String:NSObject]()
        let jsonBody = "{\"uniqueKey\": \"\(studentId!)\", \"firstName\": \"\(firstName!)\", \"lastName\": \"\(lastName!)\",\"mapString\": \"\(location)\", \"mediaURL\": \"\(url)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}"
        taskForPOSTMethod(parse, method: Methods.ParseStudentLocation, parameters: parameters, jsonBody: jsonBody) {
            (result, error) in
            if let error = error {
                completionHandlerForResults(success: false, error: error)
            }
            else if let _ = result[JSONResponseKeys.CreatedAt] as? String {
                completionHandlerForResults(success: true, error: nil)
            }
            else {
                completionHandlerForResults(success: false, error: error)
            }
        }
    }
    
    //Used to logout
    func logout(completionHandlerForResults: ((success: Bool, error: NSError?) -> Void)?) {
        let parameters = [String:NSObject]()
        taskForDELETEMedthod(udacity, method: Methods.Session, parameters: parameters) {
            (result, error) in
            self.firstName = nil
            self.lastName = nil
            if let error = error {
                completionHandlerForResults?(success: false, error: error)
            }
            else if let _ = result[JSONResponseKeys.Session] as? String {
                completionHandlerForResults?(success: true, error: nil)
            }
            else {
                completionHandlerForResults?(success: false, error: error)
            }
        }
    }
}