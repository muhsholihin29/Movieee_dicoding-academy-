//
//  MovieTableViewCell.swift
//  MovieTableViewCell
//
//  Created by Sholi on 29/07/21.
//

import UIKit



class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var categoryMovie: UILabel!
    @IBOutlet var movieCollectionView: UICollectionView!
    
    weak var delegate: MovieDelegate?
    
    static let identifier = "MovieTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MovieTableViewCell", bundle: nil)
    }
    
    private var movies: [Movie] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieCollectionView.register(
            MovieCollectionViewCell.nib(),
            forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with movies: [Movie]){
        self.movies = movies
        movieCollectionView.reloadData()
    }
}

extension MovieTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell {
            
            cell.configure(with: movies[indexPath.row])
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    
}

extension MovieTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            let movie = movies[indexPath.row]            
            delegate?.didSelectItem(movie: movie)
    }
}
extension MovieTableViewCell: MovieDelegate {
    
    func didSelectItem(movie: Movie) {
        delegate?.didSelectItem(movie: movie)
        }
}
