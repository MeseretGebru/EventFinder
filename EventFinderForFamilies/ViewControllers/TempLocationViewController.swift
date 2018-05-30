//
//  TempLocationViewController.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/26/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class TempLocationViewController: UIViewController,  CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    private var annotations = [MKAnnotation]()
    var pinAnnotationView: MKPinAnnotationView!
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .standard
        map.showsUserLocation = true
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        locationManager.delegate = self
        showSampleData()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkLocationAuthorizationStatus()
    }
    
    func showSampleData() {
        //you might have some function to pull this in
        // someArrayofVenues
        // iterate through that list to turn each event.venue into a pin
        
        let venue = ["lat": 40.7851676940918, "lon": -73.94332122802734]
        
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = CLLocationCoordinate2DMake(venue["lat"]!, venue["lon"]!)
        newAnnotation.title = "@ C4Q WITH CAM!"
        mapView.addAnnotation(newAnnotation)
        
        
        //this is just to center the map on our test point
        var testLocation = CLLocation(latitude: venue["lat"]!, longitude: venue["lon"]!)
        centerMapOnLocation(location: testLocation)
        
    }
    
    private func loadData() {
        
    }
    
    func addSubView(){
        view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
    //To check if the user has granted permissions to use their current location
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            showSampleData()
            //            centerMapOnLocation(location: locationManager.location!)
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    
    
}
