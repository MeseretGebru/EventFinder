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
 /*   let locationView = LocationView()
//    var currentSelectedEvent = Event!
    
    private var annotations = [MKAnnotation]()
    var pinAnnotationView: MKPinAnnotationView!
    
    var currentSelectedIndex: Int = 0 {
        didSet{
            //let titleAtSelectedIndex = locationView//boroughArray[currentSelectedIndex]
            let loadEvents: ([Event]) -> Void = {(onlineEvents:[Event]) in
                DispatchQueue.main.async {
                    self.events.removeAll()
                    self.locationView.mapView.removeAnnotations(self.annotations)
                    self.annotations.removeAll()
                    self.events = onlineEvents
                    if self.events.isEmpty{
                        self.noEventAlert()
                    }
                }
            }
            EventAPIClient.manager.getEvents(catId: 22, lat: eventLatitude, lon: eventLongitude, radius: 50, completionHandler: onlineEvent, errorHandler: {print($0)})
                
                
                        }
    }
    
    var events = [Event](){
        didSet{
            // creating annotations
            for event in events {
                guard let eventLatitude = event.venue?.lat,
                    let eventLongitude = event.venue?.lon ,
                 //   let doubleLat = eventLatitude,
                  //  let doubleLong = eventLongitude else {continue}
                
      //          let annotation = MKPointAnnotation()
      //          annotation.coordinate = CLLocationCoordinate2DMake(doubleLat, doubleLong)
    //            annotation.title = event.name //this is the name that will show right unser the pin
     //           annotations.append(annotation)
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
        locationView.mapView.delegate = self
        
        
    }
    
    
    func askUserForPermission(){
        let _ = LocationService.manager.checkForLocationServices()
    }
    
    func setupNavBar(){
        navigationItem.title = "One-Stop-Shop"
        //Add right bar button
        
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
            
            if let annotationIndex = index {
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
 //       currentSelectedEvent = event
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
        let alertController = UIAlertController(title: "No Job Centers",
                                                message:"There are no job centers in this zipcode. Please search another zipcode",
                                                preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) //for other actions add in actions incompletion{}
        alertController.addAction(okAction)
        //present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    */
}
