 //
 //  NowPlayingViewController.swift
 //  Flix_w1_EricKim
 //
 //  Created by kimeric on 1/17/18.
 //  Copyright © 2018 EricKim. All rights reserved.
 //
 
 import UIKit
 import AlamofireImage
 
 class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
//    var movies: [[String: Any]] = []
    var movies: [Movie] = []
    
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 203.5
        
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
            }
        }
        
        fetchMovies()
        
    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchMovies()
    }
    
    
    func fetchMovies(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
//                print(error.localizedDescription)
//                self.activityIndicator.stopAnimating()
                print("error--", error.localizedDescription)
                self.createAlert(title: "No Network!", message: "Please check if you are connected to the internet")
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
                
                
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let moviesDictionary = dataDictionary["results"] as! [[String: Any]]
                
                // TODO: Get the array of movies
//                let movies = dataDictionary["results"] as! [[String: Any]]
                
                // TODO: Store the movies in a  property to use elsewhere
//                self.movies = movies
                
                self.movies = []
                for dictionary in moviesDictionary{
                    let movie = Movie(dictionary: dictionary)
                    self.movies.append(movie)
                }
                
                // TODO: Reload your table view data
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }
        }
        task.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("total movies in NowPlayingViewController are ", movies.count)
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        cell.movie = movie
        
//        let title = movie["title"] as! String
//        let overview = movie["overview"] as! String
//
//        cell.titleLabel.text = title
//        cell.overviewLabel.text = overview
//
//        let posterPathString = movie["poster_path"] as! String
//        let baseURLString = "https://image.tmdb.org/t/p/w500"
//
//        let posterURL = URL(string: baseURLString + posterPathString)!
//        cell.posterImageView.af_setImage(withURL: posterURL)
//
        
        return cell
    }

    func createAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(OKAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
 }
