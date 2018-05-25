//
//  Events.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/25/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

//struct Result: Codable {
//    let results: [Category]
//}
//
//struct Category: Codable {
//    let name: String          //"name": "Arts & Culture",
//    let sort_name: String    //"sort_name": "Arts & Culture",
//    let id: Int             //"id": 1,
//    let shortname: String  //"shortname": "Arts"
//
//}

struct Category: Codable {
    let id : Int
    let name: String
    let photo: Photo
}
struct Photo :Codable{
    let id: Int
    let photo_link: String
    let type: String
}

