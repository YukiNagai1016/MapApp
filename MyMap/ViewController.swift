//
//  ViewController.swift
//  MyMap
//
//  Created by 優樹永井 on 2019/03/21.
//  Copyright © 2019 com.nagai. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var displayMap: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputTextField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let searchKey = textField.text {
            print(searchKey)
            
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(searchKey) { (placemarks, error) in
                if let unwrapPlacemarks = placemarks {
                    if let firstPlacemark = unwrapPlacemarks.first {
                        if let location = firstPlacemark.location {
                            let targetCoordinate = location.coordinate
                            print(targetCoordinate)
                            let pin = MKPointAnnotation()
                            pin.coordinate = targetCoordinate
                            pin.title = searchKey
                            self.displayMap.addAnnotation(pin)
                            self.displayMap.region = MKCoordinateRegion(center: targetCoordinate, latitudinalMeters: 500.0, longitudinalMeters: 500.0)
                        }
                    }
                }
            }
        }
        return true
    }
    
    @IBAction func changeMapButton() {
        if displayMap.mapType == .standard {
            displayMap.mapType = .satellite
        } else if displayMap.mapType == .satellite {
            displayMap.mapType = .hybrid
        } else if displayMap.mapType == .hybrid {
            displayMap.mapType = .satellite
        } else if displayMap.mapType == .satellite {
            displayMap.mapType = .hybridFlyover
        } else if displayMap.mapType == .hybridFlyover {
            displayMap.mapType = .mutedStandard
        } else {
            displayMap.mapType = .standard
        }
    }

}

