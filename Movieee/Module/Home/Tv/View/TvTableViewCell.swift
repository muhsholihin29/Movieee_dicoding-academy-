//
//  TvTableViewCell.swift
//  TvTableViewCell
//
//  Created by Sholi on 31/07/21.
//

import UIKit

class TvTableViewCell: UITableViewCell {

    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var tvCollectionView: UICollectionView!
    
    weak var delegate: TvDelegate?
    
    static let identifier = "TvTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "TvTableViewCell", bundle: nil)
    }
    
    private var tv: [Tv] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tvCollectionView.register(
            TvCollectionViewCell.nib(),
            forCellWithReuseIdentifier: TvCollectionViewCell.identifier)
        tvCollectionView.dataSource = self
        tvCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with tv: [Tv]){
        self.tv = tv
        tvCollectionView.reloadData()
    }
}

extension TvTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tv.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TvCollectionViewCell.identifier, for: indexPath) as? TvCollectionViewCell {
            
            cell.configure(with: tv[indexPath.row])            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    
}

extension TvTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            let tv = tv[indexPath.row]
            delegate?.didSelectItem(tv: tv)
    }
}
extension TvTableViewCell: TvDelegate {
    
    func didSelectItem(tv: Tv) {
        delegate?.didSelectItem(tv: tv)
        }
}
