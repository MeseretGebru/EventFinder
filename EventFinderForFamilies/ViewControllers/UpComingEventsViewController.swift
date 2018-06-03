//
//  UpCamingEventsViewController.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation

class UpComingEventsViewController: UIViewController {
    
    let upComingEventsView = UpComingEventView()
    let locationView = LocationView()
    var annotations = [MKAnnotation]()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        label.textColor = .white //UIColor(displayP3Red: 0.537, green: 0.537, blue: 0.537, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Events"
        return label
    }()
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Stylesheet.Colors.MediumSkyBlue
        return view
    }()
    
    var upComingEvents = [Event](){
        didSet {
            DispatchQueue.main.async {
                self.upComingEventsView.tableView.reloadData()
            }
            
            var annotations = [MKAnnotation]() // to add pins on the map
            
            upComingEvents.forEach {
                let annotation = MKPointAnnotation()
                if let lat = $0.venue?.lat, let lon = $0.venue?.lon {
                    annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    annotation.title = $0.venue?.name
                    annotations.append(annotation)
                }
                
            }
            
            locationView.mapView.removeAnnotations(self.annotations)
            self.annotations = annotations
            DispatchQueue.main.async {
                self.locationView.mapView.addAnnotations(self.annotations)
                self.locationView.mapView.showAnnotations(self.annotations, animated: true)
                print("Annotation count: \(self.annotations.count)")
            }
        }
    }
    
    var idCategory: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Stylesheet.Colors.Lapislazuli
        upComingEventsView.tableView.delegate = self
        upComingEventsView.tableView.dataSource = self
        upComingEventsView.tableView.estimatedRowHeight = 200
        upComingEventsView.tableView.rowHeight = UITableViewAutomaticDimension
        locationView.mapView.delegate = self
        locationView.mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "mapEvent")
        setupMiddleView()
        setUpConstraintTopView()
        setUpConstraintBottomView()
        loadData()
    }
    
    func loadData(){
        //"lat": 40.7851676940918, "lon": -73.94332122802734
        EventAPIClient.manager.getEvents(catId: idCategory!, lat: 40.7851676940918, lon: -73.94332122802734, radius: 50, completionHandler: { (arrEvents) in
            self.upComingEvents = arrEvents
            print(arrEvents.count)
        }, errorHandler: {print($0)})
    }
    
    //  Setup views
    func setUpConstraintTopView(){
        view.addSubview(locationView)
        locationView.backgroundColor = .yellow
        locationView.snp.makeConstraints { (topView) in
            topView.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            topView.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            topView.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            topView.bottom.equalTo(titleView.snp.top)
        }
        
    }
    
    func setupMiddleView(){
        view.addSubview(titleView)
        view.addSubview(titleLabel)
        titleView.backgroundColor = .orange
        titleView.snp.makeConstraints { (middleView) in
            middleView.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            middleView.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            middleView.width.equalTo(view.snp.width)
            middleView.height.equalTo(view.snp.width).multipliedBy(0.1)
        }
        
        titleLabel.snp.makeConstraints { (label) in
            label.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            label.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY)
        }
    }
    
    func setUpConstraintBottomView(){
        view.addSubview(upComingEventsView)
        upComingEventsView.backgroundColor = .green
        upComingEventsView.snp.makeConstraints { (bottomView) in
            bottomView.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            bottomView.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            bottomView.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            bottomView.top.equalTo(titleView.snp.bottom)
        }
    }
}

extension UpComingEventsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upComingEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let upComingEvent = upComingEvents[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! UpComingEventTableViewCell
//        cell.eventImage.image = nil
//
//        cell.eventName.text = upComingEvent.name
//        cell.venueName.text = upComingEvent.venue?.name
        
        cell.configureCell(event: upComingEvent)
//        print("\(upComingEvent.name): \(upComingEvent.group?.photo?.photo_link ?? "No Image")")
        
//        if let photoLink = upComingEvent.group?.photo?.photo_link {
//            ImageService.manager.getImage(from: photoLink) { (imageOnline) in
//                cell.eventImage.image = imageOnline
//            }
//        } else {
//            cell.eventImage.image = #imageLiteral(resourceName: "Active")
//        }
        
        cell.setNeedsLayout()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = upComingEvents[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.event = selectedEvent
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
//---------------------------
//MARK: Maps delegate functions
extension UpComingEventsViewController: MKMapViewDelegate{
    //similar to didSelect in tableviews
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //find the place selected and set that place to be the current place
       // let index = annotations.index{$0 === view.annotation}
       // guard let annotationIndex = index else { print("index is nil"); return }
        ////// let event = events[annotationIndex]
        
        //////  currentSelectedEvent = event
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
//        //present the detail view controller
//                let detailVC = DetailViewController(event: selectedEvent)
//                navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //setting up annotation views

        //setting up the blue dot
        if annotation is MKUserLocation {return nil}

        // setup annotation view for map
        // we can fully customize the marker annotation view
        let eventAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "mapEvent") //MKMarkerAnnotationView -> the view on top of the pin
        eventAnnotationView?.canShowCallout = true
        eventAnnotationView?.annotation = annotation
        eventAnnotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

        return eventAnnotationView
    }
}

//MARK: alerts
extension UpComingEventsViewController {
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

