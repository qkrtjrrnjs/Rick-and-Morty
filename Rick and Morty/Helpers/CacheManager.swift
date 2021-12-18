//
//  CacheManager.swift
//  Rick and Morty
//
//  Created by Chris Park on 12/18/21.
//

import Foundation
import UIKit

class CacheManager {
    static let shared = CacheManager()
    
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let imageCache = NSCache<NSString, UIImage>()
        imageCache.countLimit = 100
        imageCache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        return imageCache
    }()
    
    func add(urlString: String, image: UIImage) {
        imageCache.setObject(image, forKey: urlString as NSString)
    }
    
    func get(urlString: String) -> UIImage? {
        return imageCache.object(forKey: urlString as NSString)
    }
}
