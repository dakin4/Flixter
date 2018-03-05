//
//  Movie.swift
//  Flixter
//
//  Created by David King on 3/4/18.
//  Copyright © 2018 David King. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var posterUrl: URL?
    var overview: String?
    var releaseDate: String?
    var backdropURL: URL?
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        
    if let posterPathString =  dictionary["poster_path"] as? String
    {
         let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        if let site = URL(string: baseURLString + posterPathString) {
            
            posterUrl = site
            
        }
        
        
        }
        else{
            print("no Poster url")
        }
        
        
        if let ovrview = dictionary["overview"] as? String{
            
            overview = ovrview
            
        }
        else
        {
            print("no overview")
        }
        
        
        
        if let release = dictionary["release_date"] as? String
        {
            
            releaseDate = release
        }

        // Set the rest of the properties\\
        
        if let backdrop = dictionary["backdrop_path"] as? String{
            
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            if let site = URL(string: baseURLString + backdrop) {
                
                backdropURL = site
                
            }

            
            
            
        }
        
    }
    
    
    func getposterpath () -> URL?{
        
       
          return posterUrl
        
        
    }

    
    func getoverview () -> String?{

        return overview

    }
    
    func getTitle () -> String{
        
      return title
    }
    
    func getReleaseDate () -> String?{
      
        return releaseDate
        
    }
    
    
    
}
