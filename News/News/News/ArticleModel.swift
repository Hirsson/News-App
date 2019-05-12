//
//  ArticleModel.swift
//  News
//
//  Created by Axel Hirszson on 4/29/19.
//  Copyright © 2019 Axel Hirszson. All rights reserved.
//

import Foundation

protocol ArticleModelProtocol {
    
    func articlesRetrieved(_ articles: [Article])
    
}

class ArticleModel {
    
    var delegate:ArticleModelProtocol?
    
    func getArticles() {
        
        // Create a string URL
        let stringUrl = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e898747d9e374918860ea1626d2481f3"
            
            
        // Create a URL object
        let url = URL(string: stringUrl)
            
        // Check that it isn't nil
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        
        // Get the URL session
        let session = URLSession.shared
        
        // Get the DataTask object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
        
            // Check of there's no error and that there is data
            if error == nil && data != nil {
                
                do {
                    // Decode the JSON data into our structs
                    let decoder = JSONDecoder()
                    
                    let result = try decoder.decode(ArticleService.self, from: data!)
                    
                    // Pass the article back to the view controller
                    let articles = result.articles!
                    
                    // Do this on the main thread
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(articles)
                    }
                    
                }
                catch {
                    print("Couldn't decode the json")
                    return
                }   // End to catch block
                
            } // End If
            
        } // End dataTask
        
        
        
        // Resume the task to fire off the request to the API
        dataTask.resume()
        
        // Fire off the request to the API
        
        // When it returns, parse the JSON and pass the results back to the view controller via protocol and delegate pattern
       // delegate?.articleRetrieved([Article]())
        
        
    } // End getArticles
    
}  // End ArticlesModel
