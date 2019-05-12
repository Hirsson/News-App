//
//  ViewController.swift
//  News
//
//  Created by Axel Hirszson on 4/26/19.
//  Copyright © 2019 Axel Hirszson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    var model = ArticleModel()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Confrom to the tableview protocols
        tableView.delegate = self
        tableView.dataSource = self
        
        // Get the article from the article model
        model.delegate = self
        model.getArticles()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the article which the user tapped on
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            print("User didn't select an article")
            return
            
        }
    
        let article = articles[indexPath!.row]
        
        // Get a reference to the DetailViewController
        let detailVC = segue.destination as! DetailViewController
        
        // Set the articleUrl property of the DetailViewController
        detailVC.articleUrl = article.url
        
        
    }
    
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the number of articles
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        // Get article cell that tableview is trying to display
        let article = articles[indexPath.row]
        
        // TODO: Customize it
        cell.displayArticle(article)
        
        // Return that cell
        return cell
        
    }
}


extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // transition to the detail view and pass the article thst was selected
        performSegue(withIdentifier: "SegueToDetail", sender: self)
        
    }
}

extension ViewController: ArticleModelProtocol {
    
    func articlesRetrieved(_ articles: [Article]) {
      
        self.articles = articles
        tableView.reloadData()
       // print("articles came back")
        
    }
    
}
