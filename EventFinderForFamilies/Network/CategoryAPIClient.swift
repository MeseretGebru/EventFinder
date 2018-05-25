//
//  CategoryAPIClient.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/25/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
struct CategoryAPIClient {
    private init() {}
    static let manager = CategoryAPIClient()
    
    func getCategory( completionHandler: @escaping ([Category]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let apiKey = "3a612e136496614244d36d41732920"
        
        let fullUrlStr = "https://api.meetup.com/find/topic_categories/?key=\(apiKey)"
        guard let url = URL(string: fullUrlStr) else {errorHandler(AppError.badURL(str: fullUrlStr))
            return
        }
        let request = URLRequest(url: url)
        let parseDataIntoJobCenter: (Data) -> Void = {(data) in
            do {
                let results = try JSONDecoder().decode([Category].self, from: data)
                completionHandler(results)
            }
            catch {
                errorHandler(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: request, completionHandler: parseDataIntoJobCenter, errorHandler: errorHandler)
        
    }
    
}
