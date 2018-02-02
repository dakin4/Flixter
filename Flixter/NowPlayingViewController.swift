//
//  NowPlayingViewController.swift
//  Flixter
//
//  Created by David King on 1/30/18.
//  Copyright © 2018 David King. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
            let movies = dataDictionary["results"] as! [[String: Any]]
            
            //array cycles through each key in dictionary till it reaches one named "title" then the data that key holds will be casted to a string and passed to the title constant
            for movie in movies{
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
