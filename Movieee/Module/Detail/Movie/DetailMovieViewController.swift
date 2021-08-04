//
//  DetailViewCellViewController.swift
//  Movieee
//
//  Created by Sholi on 28/07/21.
//

import UIKit

class DetailMovieViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releasedLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var voteLabel: UILabel!
    @IBOutlet var revenueLabel: UILabel!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var overviewLabel: UILabel!
    
    private var presenter: DetailMoviePresenter?
    var movieId = 0
    private var movie: DetailMovie?
    static let identifier = "DetailMovieViewControllerScene"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let detailUseCase = Injection.init().provideMovie()
        presenter = DetailMoviePresenter(detailUseCase: detailUseCase)
        presenter?.getDetailMovie(id: movieId)
        
        if self.presenter?.loadingState == false {
            self.movie = self.presenter?.detailMovie
            self.setUI()
        }
    }
    
    private func setUI(){
        self.titleLabel.text = movie?.originalTitle
        self.releasedLabel.text = movie?.releaseDate
        self.genresLabel.text = movie?.genres.map{ genre in
            return genre.name ?? ""
        }.joined(separator:", ")
        self.voteLabel.text = String(movie?.voteAverage ?? 0)
        self.revenueLabel.text = String(movie?.revenue ?? 0)
        if let data = try? Data(contentsOf: URL(string: API.image+(movie?.backdropPath ?? ""))!) {
            self.backgroundImage.image = UIImage(data: data)
        }
        if let data = try? Data(contentsOf: URL(string: API.image+(movie?.posterPath ?? ""))!) {
            self.posterImage.image = UIImage(data: data)
        }
        self.overviewLabel.text = movie?.overview
    }
    

}
