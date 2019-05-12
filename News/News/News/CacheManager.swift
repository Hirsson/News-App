//
//  CacheManager.swift
//  News
//
//  Created by Axel Hirszson on 5/7/19.
//  Copyright © 2019 Axel Hirszson. All rights reserved.
//

import Foundation

class CacheManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveImageData(_ url:String, _ data:Data) {
        
        // Saving the image data to our image dictionary
        imageDictionary[url] = data
        
    }
    
    static func retrieveImageData(_ url:String) -> Data? {
        
        // Try to retrieve the value for the key that's passed into this method
        return imageDictionary[url]
        
    }
}
