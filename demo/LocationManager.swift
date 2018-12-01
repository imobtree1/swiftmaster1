//
//  LocationManager.swift
//  OneInChrist
//
//  Created by MAC on 09/20/18.
//  Copyright © 2018 Kristine Galindo. All rights reserved.
//

import Foundation
import CoreLocation


class LocationManager {
    static let shared = LocationManager()
    private init(){
    }
    
    let locationManager = CLLocationManager()
    func enableBasicLocationServices() -> CLLocationManager {
        print("enableBasicLocationServices()")
        locationManager.delegate = self as? CLLocationManagerDelegate
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("Location not determined")
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted, .denied:
            Utility.showAlert(title: "Alert", message: "Location service is disabled Please enable from settings")
            break
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location authorized")
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
            break
        }
        return locationManager
    }
}


