//
//  Article.swift
//  News
//
//  Created by Axel Hirszson on 4/26/19.
//  Copyright © 2019 Axel Hirszson. All rights reserved.
//

import Foundation

struct Article : Decodable {
    
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    
}
