//
//  CachManager.swift
//  GoodNews
//
//  Created by Elias Myronidis on 28/12/23.
//

import UIKit

class CacheManager {
    static let shared = CacheManager()

    let cache = NSCache<NSString, UIImage>()

    func addToCache(_ image: UIImage, for key: NSString) {
        cache.setObject(image, forKey: key)
    }

    func object(for key: NSString) -> UIImage? {
        cache.object(forKey: key)
    }
}
