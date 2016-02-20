//
//  APIConstants.swift
//  On The Map
//
//  Created by Christopher Luc on 2/17/16.
//  Copyright © 2016 Christopher Luc. All rights reserved.
//

import Foundation

extension APIClient {
    // MARK: Constants
    struct Constants {
        
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "/api"
        
        static let ParseScheme = "https"
        static let ParseHost = "api.parse.com"
        static let ParsePath = "/1"

    }
    
    struct Methods {
        static let Session = "/session"
        static let User = "/users/{id}"
        static let ParseStudentLocation = "/classes/StudentLocation"
    }
    
    struct ParameterKeys {
        static let Username = "username"
        static let Password = "password"
    }
    
    struct JSONResponseKeys {
        static let Session = "session"
        static let SessionId = "id"
    }
}