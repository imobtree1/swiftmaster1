//
//  LocationViewController.swift
//  demo
//
//  Created by Imobtree Solutions on 6/26/18.
//  Copyright © 2018 Imobtree Solutions. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

    class LocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
        
        @IBOutlet weak var mapView: MKMapView!
        var locationManager: CLLocationManager!
        var previousLocation : CLLocation!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            locationManager.delegate = self;
            
            // user activated automatic authorization info mode
            var status = CLLocationManager.authorizationStatus()
            if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
                // present an alert indicating location authorization required
                // and offer to take the user to Settings for the app via
                // UIApplication -openUrl: and UIApplicationOpenSettingsURLString
                locationManager.requestAlwaysAuthorization()
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            
            
            //mapview setup to show user location
            mapView.delegate = self
            mapView.showsUserLocation = true
            mapView.mapType = MKMapType(rawValue: 0)!
            mapView.userTrackingMode = MKUserTrackingMode(rawValue: 2)!
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
            mapView.mapType = MKMapType(rawValue: 0)!
        }
        
        
        override func viewWillAppear(_ animated: Bool) {
            locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            locationManager.stopUpdatingHeading()
            locationManager.stopUpdatingLocation()
        }
        
        // MARK :- CLLocationManager delegate
        func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
            
            //println("present location : \(newLocation.coordinate.latitude),\(newLocation.coordinate.longitude)")
            //drawing path or route covered
            if let oldLocationNew = oldLocation as CLLocation?{
                let oldCoordinates = oldLocationNew.coordinate
                let newCoordinates = newLocation.coordinate
                var area = [oldCoordinates, newCoordinates]
                var polyline = MKPolyline(coordinates: &area, count: area.count)
                mapView.add(polyline)
            }
            
            
            //calculation for location selection for pointing annoation
            if let previousLocationNew = previousLocation as CLLocation?{
                //case if previous location exists
                if previousLocation.distance(from: newLocation) > 200 {
                    addAnnotationsOnMap(locationToPoint: newLocation)
                    previousLocation = newLocation
                }
            }else{
                //case if previous location doesn't exists
                addAnnotationsOnMap(locationToPoint: newLocation)
                previousLocation = newLocation
            }
        }
        
        // MARK :- MKMapView delegate
        func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
            
            if (overlay is MKPolyline) {
                var pr = MKPolylineRenderer(overlay: overlay)
                pr.strokeColor = UIColor.red
                pr.lineWidth = 5
                return pr
            }
            
            return nil
        }
        
        //function to add annotation to map view
        func addAnnotationsOnMap(locationToPoint : CLLocation){
            
            var annotation = MKPointAnnotation()
            annotation.coordinate = locationToPoint.coordinate
            var geoCoder = CLGeocoder ()
            geoCoder.reverseGeocodeLocation(locationToPoint, completionHandler: { (placemarks, error) -> Void in
                if let placemarks = placemarks as? [CLPlacemark], placemarks.count > 0 {
                    var placemark = placemarks[0]
                    var addressDictionary = placemark.addressDictionary;
                    annotation.title = addressDictionary!["Name"] as? String
                    self.mapView.addAnnotation(annotation)
                }
            })
        }
        
}
