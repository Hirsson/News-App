//
//  ArticleService.swift
//  News
//
//  Created by Axel Hirszson on 4/29/19.
//  Copyright © 2019 Axel Hirszson. All rights reserved.
//

import Foundation

struct ArticleService : Decodable {
    
    var totalResults:Int?
    var articles:[Article]?
}
