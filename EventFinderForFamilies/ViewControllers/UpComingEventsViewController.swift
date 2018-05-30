//
//  UpCamingEventsViewController.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/29/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class UpComingEventsViewController: UIViewController {
    
    let upComingEventsView = UpComingEventView()
    
    var upComingEvents = [Event](){
        didSet {
            upComingEventsView.tableView.reloadData()
        }
    }
    
    lazy var idCategory: Int = {
        return 542
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upComingEventsView.tableView.delegate = self
        upComingEventsView.tableView.dataSource = self
        upComingEventsView.tableView.rowHeight = 60
        setUpConstraint()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        //"lat": 40.7851676940918, "lon": -73.94332122802734
        EventAPIClient.manager.getEvents(catId: idCategory, lat: 40.7851676940918, lon: -73.94332122802734, radius: 50, completionHandler: { (arrEvents) in
            self.upComingEvents = arrEvents
        }, errorHandler: {print($0)})
    }
    
    func setUpConstraint(){
        view.addSubview(upComingEventsView)
        upComingEventsView.translatesAutoresizingMaskIntoConstraints = false
        upComingEventsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        upComingEventsView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5).isActive = true
        upComingEventsView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        upComingEventsView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
}

extension UpComingEventsViewController: UITableViewDelegate,UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upComingEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let upComingEvent = upComingEvents[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! UpComingEventTableViewCell
//        cell.textLabel?.text = upComingEvent.name
//        cell.detailTextLabel?.text = (upComingEvent.venue?.address_1)! + "\n" + (upComingEvent.venue?.name)!
        cell.eventName.text = upComingEvent.name
        cell.venue.text = upComingEvent.venue?.name
        cell.eventAddress.text = upComingEvent.venue?.address_1
        cell.setNeedsLayout()
        return cell
    }
}
