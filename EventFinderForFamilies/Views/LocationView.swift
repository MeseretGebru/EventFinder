//
//  LocationView.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/26/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation


class LocationView: UIView {

    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true //shows users current location
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("New York, New York", completionHandler: { (placemark, error) in
            if let placemark = placemark {
                let location = placemark[0].location!
                let lat = location.coordinate.latitude
                let long = location.coordinate.longitude
                map.setCenter(location.coordinate, animated: true)
                //numbers are in meters
                //this sets the center that is zoomed in around your location
                let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 15000, 15000)
                map.setRegion(region, animated: true)
                
            }
        })
        return map
    }()
    
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .green
        setupViews()
    }
    
    func setupViews() {
        setupMapView()
        
    }
    
    
    func setupMapView() {
        addSubview(mapView)
        self.mapView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top)
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.bottom.equalTo(snp.bottom)
            
        }
    }
}


