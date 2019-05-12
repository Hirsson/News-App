//
//  ArticleCell.swift
//  News
//
//  Created by Axel Hirszson on 5/6/19.
//  Copyright © 2019 Axel Hirszson. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay:Article?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func displayArticle(_ article:Article) {
        
        // Set the label and imageView to invisible
        headlineLabel.alpha = 0
        articleImageView.alpha = 0
        
        // Clear the imageView (in this case cell is being reused)
        articleImageView.image = nil
        
        // Hold a reference to the article
        articleToDisplay = article
        
        // Display the headline
        headlineLabel.text = articleToDisplay!.title!
        
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            
            self.headlineLabel.alpha = 1
            
            }, completion: nil)
        
        // Check if the article has an image
        let urlString = articleToDisplay!.urlToImage
        
        guard urlString != nil else {
            return
            
        }
        
        // Before we go and download the image, check if it's in the cache
        let cachedData = CacheManager.retrieveImageData(urlString!)
        
        if cachedData != nil {
            
            // If the cached data exists, use that instead
            articleImageView.image = UIImage(data: cachedData!)
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.articleImageView.alpha = 1
                
            }, completion: nil)
            
            return
            
        }
        
        // Create url object
        let url = URL(string: urlString!)
        
        // Check that it isn't nil
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        
        // Get the session
        let session = URLSession.shared
        
        // Create the datatask
        let dataTask = session.dataTask(with: url!) {
            
            (data, response, error) in
            
            // Check that there's no error and that there is data
            if error == nil && data != nil {
                
                // Save the image data to cache
                CacheManager.saveImageData(urlString!, data!)
                
                // Before we set the image, ensure that this image data is still relevent to the article
                if self.articleToDisplay!.urlToImage == urlString! {
                    
                    // Set the imageView with the data
                    DispatchQueue.main.async {
                        self.articleImageView.image = UIImage(data: data!)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            
                            self.articleImageView.alpha = 1
                            
                        }, completion: nil)
                        
                    }
                    
                    
                } // End if
                
            } // End if
            
        } // End data task
        
        // Fire the datatask
        dataTask.resume()
        
    }
            
}
