//
//  LocationViewController.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation


class LocationViewController: UIViewController {
 
    let locationView = LocationView()
    let upComingEventView = UpComingEventView()
    
    var idCategory: Int?
    
    private var annotations = [MKAnnotation]()
    var pinAnnotationView: MKPinAnnotationView!
    var currentSelectedEvent : Event!
    var events : [Event] = []{
        didSet{
            // creating annotations
            upComingEventView.tableView.reloadData()
            var annotations : [MKAnnotation] = []
            for event in events {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: (event.venue?.lat)!, longitude: (event.venue?.lon)!)
                annotation.title = event.name //this is the name that will show right unser the pin
                annotations.append(annotation)
            }
            // adding annotations to mapview - update ui
            DispatchQueue.main.async {
                self.locationView.mapView.addAnnotations(self.annotations)
                self.locationView.mapView.showAnnotations(self.annotations, animated: true)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(locationView)
        setupNavBar()
        askUserForPermission()
        setupLocationServices()
        locationView.mapView.delegate = self
       // upComingEventView.tableView.dataSource = self
       // upComingEventView.tableView.delegate = self
       // LocationService.manager.delegate = self
        loadData()
        locationView.mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: "mapAnnotationView")
    }
    func loadData(){
        //"lat": 40.7851676940918, "lon": -73.94332122802734
        EventAPIClient.manager.getEvents(catId: idCategory!, lat: 40.7851676940918, lon: -73.94332122802734, radius: 50, completionHandler: { (arrEvents) in
            self.events = arrEvents
        }, errorHandler: {print($0)})
    }
    
    
    func askUserForPermission(){
        let _ = LocationService.manager.checkForLocationServices()
    }
    
    func setupNavBar(){
        navigationItem.title = "Location View"
        //Add right bar button
    }
    func setupLocationServices(){
        
    }
}


//MARK: Maps delegate functions
extension LocationViewController: MKMapViewDelegate{
    
    //similar to cell for row at in table view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //setting up annotation views
        
        //setting up the blue dot
        if annotation is MKUserLocation{
            return nil
        }
        
        // setup annotation view for map
        // we can fully customize the marker annotation view
        var eventAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "EventAnnotationView") //MKMarkerAnnotationView -> the view on top of the pin
        
        //if there is no annotation view, create a new one
        if eventAnnotationView == nil {
            eventAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "EventAnnotationView")
            eventAnnotationView?.canShowCallout = true
            
            let index = annotations.index{$0 === annotation}
            //annotationIndex
            if let _ = index {
                //let jobCenter = jobCenters[annotationIndex]
    //            eventAnnotationView?.glyphText =
                //jobCenterAnnotationView?.image = #imageLiteral(resourceName: "orangeImage").reDrawImage(using: CGSize(width: 50, height: 50))//image is there.. It's just greyed out
                eventAnnotationView?.contentMode = .scaleAspectFit
            }
            eventAnnotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            eventAnnotationView?.annotation = annotation
        }
        //TODO: For later: setting jobCenterAnnotationView's image
        return eventAnnotationView
    }
    
    
    //similar to didSelect in tableviews
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //find the place selected and set that place to be the current place
        let index = annotations.index{$0 === view.annotation}
        guard let annotationIndex = index else { print("index is nil"); return }
        let event = events[annotationIndex]
        
        currentSelectedEvent = event
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //present the detail view controller
//        let detailVC = DetailViewController(jobCenter: currentSelectedJobCenter)
//        navigationController?.pushViewController(detailVC, animated: true)
//        print("This is going to the List View Controller")
    }
}

//MARK: alerts
extension LocationViewController {
    func noEventAlert(){
        let alertController = UIAlertController(title: "No Events",
                                                message:"There are no events in this this area",
                                                preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) //for other actions add in actions incompletion{}
        alertController.addAction(okAction)
        //present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
 
}
