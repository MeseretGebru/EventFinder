//
//  Event.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/25/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
struct AllEvent : Codable {
    let events: [Event]
}
struct Event : Codable {
    let created: Int
    let fee : Fee
    let venue : Venue
    let gruoup : Group
    let id: Int
    let name : String
    let status: String
    let local_date: String
    let local_time: String
    let link : String
    let description: String
}
struct Fee : Codable {
    let accepts : String
    let amount : Int
}
struct Venue: Codable {
    let id : Int
    let name : String
    let lat : Int
    let lon : Int
    let address_1: String
    let city: String
    let zip : String
    let state:String
}
struct Group :Codable {
    let created: Int
    let name: String
    let id: Int
    let join_mode: String
    let lat: Double
    let lon: Double
    let urlname: String
}


