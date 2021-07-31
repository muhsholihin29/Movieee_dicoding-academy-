//
//  MovieTableViewCell.swift
//  Movieee
//
//  Created by Sholi on 28/07/21.
//

import UIKit

protocol MovieDelegate: AnyObject {
    func didSelectItem(movie: Movie)
}

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterMovie: UIImageView!
    @IBOutlet var titleMovie: UILabel!
    @IBOutlet var ratingMovie: UILabel!
    
    static let identifier = "MovieCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MovieCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configure(with model: Movie) {
        if let data = try? Data(contentsOf: URL(string: API.image+model.posterPath)!) {
                self.posterMovie.image = UIImage(data: data)
            }
        self.titleMovie.text = model.originalTitle
        self.ratingMovie.text = String(model.voteAverage)
    }
    
}
