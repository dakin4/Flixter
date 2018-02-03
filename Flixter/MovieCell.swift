//
//  MovieCell.swift
//  Flixter
//
//  Created by David King on 2/1/18.
//  Copyright © 2018 David King. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
   
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var TypeDes: UILabel!
    
    override func awakeFromNib() {
      
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
