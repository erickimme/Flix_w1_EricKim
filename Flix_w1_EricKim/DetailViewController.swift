//
//  DetailViewController.swift
//  Flix_w1_EricKim
//
//  Created by kimeric on 1/30/18.
//  Copyright © 2018 EricKim. All rights reserved.
//

import UIKit

enum MovieKeys {
    static let title = "title"
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
    static let releaseDate = "release_date"
    static let overview = "overview"
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
//    var movie: [String : Any]?
    
    var movie: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()

        // assuming we have movie in poster,
        if let movie = movie {
            titleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate
            overviewLabel.text = movie.overview
            
//            titleLabel.text = movie[MovieKeys.title] as? String
//            releaseDateLabel.text = movie["release_date"] as? String
//            overviewLabel.text = movie["overview"] as? String
//            let backdropPathString = movie[MovieKeys.backdropPath] as! String
//            let poseterPathString = movie[MovieKeys.posterPath] as! String
//            let baseURLString = "https://image.tmdb.org/t/p/w500"
//
//            let backdropURL = URL(string: baseURLString + backdropPathString)!
//            backDropImageView.af_setImage(withURL: backdropURL)
//
//            let posterURL = URL(string: baseURLString + poseterPathString)!
//            posterImageView.af_setImage(withURL: posterURL)
            
            backDropImageView.af_setImage(withURL: movie.backdropURL!)
            posterImageView.af_setImage(withURL: movie.posterUrl!)
        }
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
