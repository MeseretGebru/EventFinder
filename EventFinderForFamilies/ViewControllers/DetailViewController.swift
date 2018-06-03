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
         navigationController?.title = "Detailed"
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
       
    }
    
    
    func configureNavBar() {
        configureView()
    }

    
    func configureView() {
        guard let eventLabel.text = event.name! else { return }

        guard let nameLabel.text = (event.venue?.name) else {return}
       
        addressLabel.text = event.venue?.address_1
        phoneLabel.text = event.venue?.phone
        
         //set the center of the map to New York
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(40.6974034,-74.1197636)

        mapView.setCenter(annotation.coordinate, animated: true)
        mapView.addAnnotation(annotation)

    }
   
    
 

 
}
