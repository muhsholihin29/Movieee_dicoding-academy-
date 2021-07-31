//
//  HomeViewController.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import UIKit
import Combine

class MovieViewController: UIViewController {
    
    @IBOutlet var movieTableView: UITableView!
    
    private var presenter: MoviePresenter?
    private var cancellables = Set<AnyCancellable>()
    private var movies: [[Movie]] = [[]]
    var categoryName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieUseCase = Injection.init().provideMovie()
        presenter = MoviePresenter(movieUseCase: movieUseCase)
        presenter?.getPopularMovies()
        presenter?.getTopRatedMovies()
        presenter?.getNowPlayingMovies()
        presenter?.getUpcomingMovies()
        self.observeMovie()
        self.navigationItem.title = "Movie Catalogue"
        
        categoryName.append("POPULAR MOVIES")
        categoryName.append("TOP RATED MOVIES")
        categoryName.append("NOW PLAYING MOVIES")
        categoryName.append("UPCOMING MOVIES")
        
        movieTableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    
    private func observeMovie() {
        presenter?.objectWillChange
            .sink { (_) in
                DispatchQueue.main.async {
                    if self.presenter?.loadingState == false {
                        self.movies = self.presenter?.movies ?? [[]]
                        self.movieTableView.reloadData()
                    }
                }
            }
            .store(in: &cancellables)
    }
}

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell
        {
            cell.categoryMovie.text = categoryName[indexPath.item]
            cell.configure(with: movies[indexPath.item])
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}

extension MovieViewController: MovieDelegate {
    func didSelectItem(movie: Movie) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyBoard.instantiateViewController(withIdentifier: DetailMovieViewController.identifier) as? DetailMovieViewController {
            detailVC.movieId = movie.id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
