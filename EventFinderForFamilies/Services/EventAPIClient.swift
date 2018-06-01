//
//  EventAPIClient.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/25/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
struct EventAPIClient {
    private init() {}
    static let manager = EventAPIClient()
    
    func getEvents(catId: Int,
                     lat: Double,
                     lon: Double,
                     radius: Double,
                     completionHandler: @escaping ([Event]) -> Void,
                     errorHandler: @escaping (Error) -> Void) {
        let apiKey = "3a612e136496614244d36d41732920"
        let fullUrlStr = "https://api.meetup.com/find/upcoming_events/?topic_category=\(catId)&lat=\(lat)&lon=\(lon)&radius=\(radius)&key=\(apiKey)&fields=group_photo"
        //https://api.meetup.com/find/upcoming_events/?topic_category=542&key=3a612e136496614244d36d41732920
        guard let url = URL(string: fullUrlStr) else {errorHandler(AppError.badURL(str: fullUrlStr))
            return
        }
        let request = URLRequest(url: url)
        let parseDataEvent: (Data) -> Void = {(data) in
            do {
                let results = try JSONDecoder().decode(AllEvent.self, from: data)
                completionHandler(results.events)
            }
            catch {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: parseDataEvent, errorHandler: errorHandler)
    }
}
