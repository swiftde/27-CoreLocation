//
//  ViewController.swift
//  CoreLocation-Tutorial
//
//  Created by Benjamin Herzog on 06.09.14.
//  Copyright (c) 2014 Benjamin Herzog. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var manager = CLLocationManager()
    var geocoder = CLGeocoder()
    var placeMark: CLPlacemark?
    
    // MARK: - ViewController-Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.requestAlwaysAuthorization()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("ERROR: \(error.localizedDescription)")
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("new Location: \(manager.location)")
        
        let currentLocation = manager.location
        
        if currentLocation != nil {
            latitudeLabel.text = "\(currentLocation.coordinate.latitude)"
            longitudeLabel.text = "\(currentLocation.coordinate.longitude)"
            
            geocoder.reverseGeocodeLocation(currentLocation, completionHandler: {
            placemarks, error in
                
                if error == nil && placemarks.count > 0 {
                    self.placeMark = placemarks.last as? CLPlacemark
                    self.adressLabel.text = "\(self.placeMark!.thoroughfare)\n\(self.placeMark!.postalCode) \(self.placeMark!.locality)\n\(self.placeMark!.country)"
                    self.manager.stopUpdatingLocation()
                    self.button.enabled = true
                }
            })
        }
    }
    
    // MARK: - IBActions

    @IBAction func buttonPressed(sender: AnyObject) {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        button.enabled = false
    }

}






















