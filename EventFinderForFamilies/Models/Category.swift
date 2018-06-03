//
//  Events.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/25/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation


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

