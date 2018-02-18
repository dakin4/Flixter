//
//  PosterViewController.swift
//  Flixter
//
//  Created by David King on 2/8/18.
//  Copyright © 2018 David King. All rights reserved.
//

import UIKit
import Alamofire

class SuperheroViewController: UIViewController, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [[String:Any]] = []

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumInteritemSpacing = 3
        
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        
        let cellsPerLine:CGFloat  = 3
        
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        
        fetchMovie()
       
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {

    return movies.count
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        
        
        let movie = movies[indexPath.item]
        
        if let posterPathString = movie["poster_path"] as? String
        {
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let posterURL = URL(string: baseURLString + posterPathString)!
            
            cell.posterImageView.af_setImage(withURL: posterURL)
            
        }
        return cell
        
        
    }

    
    func fetchMovie () {
       // movieActivityInd.startAnimating()
        //URL object // string found in
        let url = URL(string: "https://api.themoviedb.org/3/movie/284054/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language")!
        
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
                
                self.collectionView.reloadData() //reloads data once the data is fetched from the network api
               // self.refreshControl.endRefreshing()
                //self.movieActivityInd.stopAnimating()
                //array cycles through each key in dictionary till it reaches one named "title" then the data that key holds will be casted to a string and passed to the title constant
                for movie in self.movies{
                    let title = movie["title"] as! String
                    print(title)
                }
                
            }
            
        }
        
        task.resume()
        
        
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
