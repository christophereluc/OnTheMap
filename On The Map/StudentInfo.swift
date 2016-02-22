//
//  StudentInfo.swift
//  On The Map
//
//  Created by Christopher Luc on 2/21/16.
//  Copyright © 2016 Christopher Luc. All rights reserved.
//

import MapKit

class StudentInfo : NSObject, MKAnnotation {
    var createdAt: String
    var firstName: String
    var lastName: String
    var latitude: Double
    var longitude: Double
    var mapString: String
    var mediaURL: String
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(dictionary: [String:AnyObject!]) {
        createdAt = dictionary[APIClient.JSONResponseKeys.CreatedAt] as! String
        firstName = dictionary[APIClient.JSONResponseKeys.FirstName] as! String
        lastName = dictionary[APIClient.JSONResponseKeys.LastName] as! String
        longitude = dictionary[APIClient.JSONResponseKeys.Longitude] as! Double
        latitude = dictionary[APIClient.JSONResponseKeys.Latitude] as! Double
        mapString = dictionary[APIClient.JSONResponseKeys.MapString] as! String
        mediaURL = dictionary[APIClient.JSONResponseKeys.mediaURL] as! String
        coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude)
        title = "\(firstName) \(lastName)"
        subtitle = mediaURL
    }
    
    //Helper used to convert results object to student info dictionary
    static func studentInfoFromResults(results: [[String:AnyObject]]) -> [StudentInfo] {
        var studentInfo = [StudentInfo]()
        
        for result in results {
            studentInfo.append(StudentInfo(dictionary: result))
        }
        
        return studentInfo
    }
}