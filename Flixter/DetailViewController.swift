//
//  DetailViewController.swift
//  Flixter
//
//  Created by David King on 2/6/18.
//  Copyright © 2018 David King. All rights reserved.
//

import UIKit

// way to store data, easy to call instead of typing. why use this instead of constants within codepath class

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var backDropImageView: UIImageView!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var OverviewLabel: UILabel!
    
    //dictionary
    var movie : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie{
            
          titleLabel.text = movie.getTitle()
            if let release: String = movie.releaseDate {
               releaseDateLabel.text = release
            }
            
            if let overview = movie.getoverview(){
                
                OverviewLabel.text = overview 

            }
            
            
            if let backdropPathString = movie.backdropURL{
                
                backDropImageView.af_setImage(withURL: backdropPathString)

            }
            
            
            
            if let poster = movie.getposterpath(){
                
                posterImageView.af_setImage(withURL: poster)
   
            }
       }
        
        
        
        // Do any additional setup after loading the view.
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
