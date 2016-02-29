//
//  StudentInfoAnnotation.swift
//  On The Map
//
//  Created by Christopher Luc on 2/28/16.
//  Copyright © 2016 Christopher Luc. All rights reserved.
//

import Foundation
import MapKit

class StudentInfoAnnotation : NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var mediaUrl: String
    
    init(studentInfo: StudentInfo) {
        title = studentInfo.title
        subtitle = studentInfo.subtitle
        coordinate = studentInfo.coordinate
        mediaUrl = studentInfo.mediaURL
    }
    
    //Helper used to convert dictionary of StudentInfo structs into annotations object
    static func convertDictionaryToAnnotation(data: [StudentInfo]) -> [StudentInfoAnnotation] {
        var studentInfo = [StudentInfoAnnotation]()
        
        for item in data {
            studentInfo.append(StudentInfoAnnotation(studentInfo: item))
        }
        
        return studentInfo
    }
}