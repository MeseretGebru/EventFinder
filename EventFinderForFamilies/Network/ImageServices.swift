//
//  ImageServices.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/25/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

struct ImageService {
    private init() {}
    static let manager = ImageService()
    
    func getImage(from urlStr: String, completion: @escaping (UIImage?) -> Void) {
        let imageView = UIImageView()
        if let imageCache = ImageCache.default.retrieveImageInMemoryCache(forKey: urlStr) {
            completion(imageCache)
            return
        }
        if let imageURL = URL(string: urlStr) {
            imageView.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
                if let error = error {
                    print(error)
                    return
                }
                if let image = image {
                    completion(image)
                    ImageCache.default.store(image, forKey: urlStr)
                    return
                }
            })
        }
    }
    
    func getImage2(from urlStr: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlStr) else {print("badURL"); return}
        let imageURLResquest = URLRequest(url: url)
        let imageCompletion: (Data) -> Void = { (data) in
            let image = UIImage.init(data: data)
            completion(image)
        }
        
        NetworkHelper.manager.performDataTask(with: imageURLResquest, completionHandler: imageCompletion, errorHandler: {print($0.localizedDescription)})
    }
}
