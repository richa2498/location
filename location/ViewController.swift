//
//  ViewController.swift
//  location
//
//  Created by MacStudent on 2020-01-09.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class ViewController: UIViewController,CLLocationManagerDelegate{
    
    //create variable of CLLocationManager
    
    @IBOutlet weak var mapView: MKMapView!
    var locatioManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locatioManager.delegate = self
        locatioManager.desiredAccuracy = kCLLocationAccuracyBest
        locatioManager.requestWhenInUseAuthorization()
        locatioManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //getting users location
        let userLoaction : CLLocation = locations[0]
        
        let lat = userLoaction.coordinate.latitude
        let long = userLoaction.coordinate.longitude
        
        let latDelta:CLLocationDegrees = 0.05
        let longDelta:CLLocationDegrees = 0.05
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        let loaction = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let region = MKCoordinateRegion(center: loaction, span: span)
        mapView.setRegion(region, animated: true)
        
        print(userLoaction)
        CLGeocoder().reverseGeocodeLocation(userLoaction) { (placemarks, error) in
            if let error = error {
                print(error)
            } else {
                if let placemark = placemarks?[0] {
                    
                    var  subThoroufare = ""
                    if placemark.subThoroughfare != nil {
                        subThoroufare = placemark.subThoroughfare!
                    }
                    var thoroufare = ""
                    if placemark.thoroughfare != nil {
                        thoroufare = placemark.thoroughfare!
                    }
                    var subLoaclity = ""
                    if placemark.subLocality != nil {
                        subLoaclity = placemark.subLocality!
                    }
                    var subAdministrateArea = ""
                    if placemark.subAdministrativeArea != nil {
                        subAdministrateArea = placemark.subAdministrativeArea!
                    }
                    var postalCode = ""
                    if placemark.postalCode != nil{
                        postalCode = placemark.postalCode!
                        
                    }
                    var country = ""
                    if placemark.country != nil{
                        country = placemark.country!
                    }
                    print(subThoroufare + thoroufare + "\n"+subLoaclity + "\n"+subAdministrateArea+"\n"+postalCode+"\n"+country)
                }
            }
            
            
        }
        
    }
    
}
