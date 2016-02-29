//
//  CreateInformationViewController.swift
//  On The Map
//
//  Created by Christopher Luc on 2/28/16.
//  Copyright © 2016 Christopher Luc. All rights reserved.
//

import UIKit
import MapKit

class CreateInformationViewControler : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var button: RoundedButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var studyingText: UITextView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var urlText: UITextField!
    
    let findOnMap = "Find on Map"
    let submit = "Submit"
    var latitude:Float?
    var longitude:Float?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        locationField.delegate = self
        urlText.delegate = self
        map.hidden = true
        activityIndicator.hidden = true
        urlText.hidden = true
        locationField.hidden = false
        button.setTitle(findOnMap, forState: .Normal)
        map.scrollEnabled = false
        map.userInteractionEnabled = false
    }
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func buttonAction(sender: RoundedButton) {
        if sender.titleLabel?.text == findOnMap {
            findLocation()
        }
        else if sender.titleLabel?.text == submit {
            submitLocation()
        }
    }
    
    func findLocation() {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = locationField.text
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler() {
            (localSearchResponse, error) -> Void in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidden = true
            if localSearchResponse == nil{
                self.displayAlert("Location not found", completionHandler: nil)
                return
            }
            self.placePin(localSearchResponse!)
            self.updateUi()
        }
    }
    
    func updateUi() {
        map.hidden = false
        button.setTitle("Submit", forState: .Normal)
        locationField.hidden = true
        background.backgroundColor = UIColor(red: 0, green: 0.8431, blue: 0.9176, alpha: 1.0)
        studyingText.hidden = true
        urlText.hidden = false
    }
    
    //Helper used to display alerts
    func displayAlert(text: String, completionHandler: ((action: UIAlertAction)  -> Void)?) {
        let alertController = UIAlertController(title: nil, message: text, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: completionHandler))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //Places the pin on the map
    func placePin(response: MKLocalSearchResponse){
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: response.boundingRegion.center.latitude, longitude: response.boundingRegion.center.longitude)
        let pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
        map.centerCoordinate = pointAnnotation.coordinate
        map.addAnnotation(pinAnnotationView.annotation!)
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegion(center: pointAnnotation.coordinate, span: span)
        map.setRegion(region, animated: true)
        longitude = Float(pointAnnotation.coordinate.longitude)
        latitude = Float(pointAnnotation.coordinate.latitude)
        
    }
    
    func submitLocation(){
        APIClient.sharedInstance().postLocation(locationField.text!, url: urlText.text!, latitude: latitude!, longitude: longitude!) {
            (success, error) in
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                if success {
                    self.displayAlert("Post successful!") {
                        (UIActionAlert) in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
                else {
                    self.displayAlert("Failed to post data", completionHandler: nil)
                }
            }
            
        }
    }
}
