//
//  ImageCache.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/22/26.
//

import UIKit

final class ImageCache {
    
    static let shared = ImageCache()
    
    private init() {}
    
    private let cache =
    NSCache<NSString, UIImage>()
    
    //MARK: - Save Image
    
    func save(
        image : UIImage,
        forKey key : String
        
    ) {
        
        cache.setObject(
            image,
            forKey:key as NSString
            
        )
    }
    
    //MARK: - Get Image
    
    func image(
        forKey key: String
    ) -> UIImage? {
        
        cache.object(
            forKey: key as NSString
        )
    }
    
}
