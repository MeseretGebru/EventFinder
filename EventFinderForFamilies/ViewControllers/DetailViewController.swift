//
//  DetailViewController.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 6/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import MapKit
class DetailViewController: UITableViewController {
    
    var event: Event!
    
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    // mapview
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting a background color to differentiate from cells
        view.backgroundColor = .yellow
        
        // set a zero height view for the footer to remove empty cells
        tableView.tableFooterView = UIView(frame: .zero)
        configureView()
         
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
       
    }
    
    
    func configureNavBar() {
        configureView()
    }

    
    func configureView() {
         eventLabel.text = event.name!
         nameLabel.text = (event.venue?.name) 

        addressLabel.text = event.venue?.address_1
        phoneLabel.text = event.venue?.phone
        
         //set the center of the map to New York
        let annotation = MKPointAnnotation()
       // annotation.coordinate = CLLocationCoordinate2DMake(40.6974034,-74.1197636)
        guard let lat = event.venue?.lat,
            let lon = event.venue?.lon
            else { print("no coordinates"); return }
        annotation.coordinate = CLLocationCoordinate2DMake(lat, lon)
        mapView.setCenter(annotation.coordinate, animated: true)
        mapView.addAnnotation(annotation)
        mapView.showAnnotations([annotation], animated: true)
       //mapView.centerCoordinate = event.venue.coordinate
        //mapView.isScrollEnabled = false
      
        /*******end of new********/
    }
   
    
 

 
}
