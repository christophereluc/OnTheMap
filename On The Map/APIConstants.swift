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
        static let User = "/users"
        static let ParseStudentLocation = "/classes/StudentLocation"
    }
    
    struct ParameterKeys {
        static let Username = "username"
        static let Password = "password"
        static let Limit = "limit"
        static let Order = "order"
    }
    
    struct ParameterValues {
        static let UpdatedAt = "-updatedAt"
        static let Limit = "100"
    }
    
    struct JSONResponseKeys {
        static let Account = "account"
        static let Key = "key"
        static let Session = "session"
        static let SessionId = "id"
        static let Results = "results"
        static let CreatedAt = "createdAt"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let MapString = "mapString"
        static let mediaURL = "mediaURL"
        static let User = "user"
        static let UdacityLastName = "last_name"
        static let UdacityFirstName = "first_name"
    }
}