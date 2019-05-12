//
//  DetailViewController.swift
//  News
//
//  Created by Axel Hirszson on 5/6/19.
//  Copyright © 2019 Axel Hirszson. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var webView: WKWebView!
    
    var articleUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Start the activity spinner
        spinner.alpha = 1
        spinner.startAnimating()
        
        // Set delegate for the webview
        webView.navigationDelegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Check if there's a url, if there is, then display it
        if articleUrl != nil {
            
            // Create a url object
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                return
                
            }
            
            // Create a request
            let request = URLRequest(url: url!)
        
            // Laod the request
            webView.load(request)
            
        }
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any recources that can be recreated
            
        }
        
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // Remove the spinner
        spinner.stopAnimating()
        spinner.alpha = 0
    }

}
