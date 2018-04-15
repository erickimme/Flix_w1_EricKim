//
//  MovieCell.swift
//  Flix_w1_EricKim
//
//  Created by kimeric on 1/18/18.
//  Copyright © 2018 EricKim. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    var movie: Movie!{
        didSet{
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            let posterURL = movie.posterUrl
            
            posterImageView.af_setImage(withURL: posterURL!)
        }
    }
    
    let baseURL = "https://image.tmdb.org/t/p/w500"
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
