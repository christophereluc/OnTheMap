//
//  MapViewController.swift
//  On The Map
//
//  Created by Christopher Luc on 2/17/16.
//  Copyright © 2016 Christopher Luc. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController : BaseViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func logout(sender: AnyObject) {
        logout()
    }
    
    @IBAction func refreshMap(sender: AnyObject) {
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations( annotationsToRemove )
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        dataRetrieved()
    }
    
    override func dataRetrieved() {
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            self.mapView.addAnnotations(StudentInfoAnnotation.convertDictionaryToAnnotation(StudentInfo.studentInfoDictionary))
        }
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let studentInfo = view.annotation as! StudentInfoAnnotation
        launchLink(studentInfo.mediaUrl)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKindOfClass(StudentInfoAnnotation.self) {
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
                annotationView!.canShowCallout = true
                let btn = UIButton(type: .DetailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            }
            else {
                annotationView!.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
}