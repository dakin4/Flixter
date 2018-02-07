//
//  NowPlayingViewController.swift
//  Flixter
//
//  Created by David King on 1/30/18.
//  Copyright © 2018 David King. All rights reserved.
//

import UIKit
import AlamofireImage

// make it a subclass of UITableViewDataSource
class NowPlayingViewController: UIViewController, UITableViewDataSource {
   
    @IBOutlet weak var movieActivityInd: UIActivityIndicatorView!
    
    @IBOutlet weak var tableview: UITableView!

    
    
    // refreshControl is instiated, this can be attached to a view object that inherits or is UIScrollView
    var refreshControl: UIRefreshControl!
    
    //create an array of dictionaries
    var movies:[[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

        //refreshControl object is created
         refreshControl = UIRefreshControl()
    
        
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableview.dataSource = self
        tableview.insertSubview(refreshControl, at: 0)
        fetchMovie()
    
    }
    
    func didPullToRefresh (_ refreshControl: UIRefreshControl){
        
        fetchMovie()
        
    }
    
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
   {
    return movies.count
    
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as!MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.TitleLabel.text = title
        cell.TypeDes.text = overview
        let posterPathString =  movie["poster_path"] as! String
        
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        let posterURL = URL(string: baseURLString + posterPathString)!
        
        cell.posterImageView.af_setImage(withURL:posterURL)
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //sender is person or object that inisiated the segue
        let cell = sender as! UITableViewCell
        
        if let indexPath = tableview.indexPath(for: cell){
            
            let movie = movies[indexPath.row]
            
            let detail = segue.destination as! DetailViewController
            
            detail.movie = movie
            
            
        }
        
    
        
    }
    
    
    
    
    
    func fetchMovie () {
        movieActivityInd.startAnimating()
        //URL object // string found in
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        //
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        //
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        //
        let task = session.dataTask(with: request) { (data,response,error) in
            // will run when the network request returns
            if let error = error{
                print(error.localizedDescription)

                
            }
            else if let data = data {
                //throws an error, should use a do try statement but for now will use a try! statment
                //whcich will force it to run without and if an error is thrown since nothing is set to handle it the app will crash
                
                // casting the JSON to a Dictionary
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                //casting items within the dictionary under the key results into an array of dictionaries
                let movi = dataDictionary["results"] as! [[String: Any]]
                //self.movies to show that it has the scope of the whole class its in
                self.movies = movi
              
                self.tableview.reloadData() //reloads data once the data is fetched from the network api
                self.refreshControl.endRefreshing()
                self.movieActivityInd.stopAnimating()
                //array cycles through each key in dictionary till it reaches one named "title" then the data that key holds will be casted to a string and passed to the title constant
                for movie in self.movies{
                    let title = movie["title"] as! String
                    print(title)
                }
     
            }
          
        }
        
        task.resume()

        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
