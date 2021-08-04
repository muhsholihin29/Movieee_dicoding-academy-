//
//  DetailTvController.swift
//  DetailTvController
//
//  Created by Sholi on 31/07/21.
//

import Foundation
import UIKit

class DetailTvViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releasedLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!
    @IBOutlet var voteLabel: UILabel!
    @IBOutlet var revenueLabel: UILabel!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var overviewLabel: UILabel!
    
    private var presenter: DetailTvPresenter?
    var tvId = 0
    private var tv: DetailTv?
    static let identifier = "DetailTvViewControllerScene"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let detailUseCase = Injection.init().provideTv()
        presenter = DetailTvPresenter(detailUseCase: detailUseCase)
        presenter?.getDetailTv(id: tvId)
        
        if self.presenter?.loadingState == false {
            self.tv = self.presenter?.detailTv
            self.setUI()
        }
    }
    
    private func setUI(){
        self.titleLabel.text = tv?.originalName
        self.releasedLabel.text = tv?.firstAirDate
        self.genresLabel.text = tv?.genres.map{ genre in
            return genre.name ?? ""
        }.joined(separator:", ")
        self.voteLabel.text = String(tv?.voteAverage ?? 0)
        self.revenueLabel.text = String(tv?.numberOfSeasons ?? 0)
        if let data = try? Data(contentsOf: URL(string: API.image+(tv?.backdropPath ?? ""))!) {
            self.backgroundImage.image = UIImage(data: data)
        }
        if let data = try? Data(contentsOf: URL(string: API.image+(tv?.posterPath ?? ""))!) {
            self.posterImage.image = UIImage(data: data)
        }
        self.overviewLabel.text = tv?.overview
    }
}
