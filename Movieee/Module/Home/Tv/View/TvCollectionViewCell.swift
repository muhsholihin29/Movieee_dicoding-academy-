//
//  TvCollectionViewCell.swift
//  TvCollectionViewCell
//
//  Created by Sholi on 31/07/21.
//

import UIKit

protocol TvDelegate: AnyObject {
    func didSelectItem(tv: Tv)
}

class TvCollectionViewCell: UICollectionViewCell {
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    
    static let identifier = "TvCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "TvCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with model: Tv) {
        if let data = try? Data(contentsOf: URL(string: API.image+model.posterPath)!) {
                self.posterImage.image = UIImage(data: data)
            }
        self.nameLabel.text = model.originalName
        self.ratingLabel.text = String(model.voteAverage)
    }
}
