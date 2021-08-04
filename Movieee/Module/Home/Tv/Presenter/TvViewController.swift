//
//  HomeViewController.swift
//  Tvee
//
//  Created by Sholi on 27/07/21.
//

import UIKit

class TvViewController: UIViewController {
    
    @IBOutlet var tvTableView: UITableView!
    
    private var presenter: TvPresenter?
    private var tv: [[Tv]] = [[]]
    var categoryName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tvUseCase = Injection.init().provideTv()
        presenter = TvPresenter(tvUseCase: tvUseCase)
        presenter?.getPopularTv()
        presenter?.getTopRatedTv()
        presenter?.getOnTheAirTv()
        presenter?.getAiringTodayTv()
        
        self.navigationItem.title = "Tv Catalogue"
        
        categoryName.append("POPULAR TV")
        categoryName.append("TOP RATED TV")
        categoryName.append("ON THE AIR TV")
        categoryName.append("AIRING TODAY TV")
        
        tvTableView.register(TvTableViewCell.nib(), forCellReuseIdentifier: TvTableViewCell.identifier)
        
        tvTableView.dataSource = self
        tvTableView.delegate = self
        
        if self.presenter?.loadingState == false {
            self.tv = self.presenter?.tv ?? [[]]
            self.tvTableView.reloadData()
        }
               
    }
}

extension TvViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tv.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TvTableViewCell.identifier, for: indexPath) as? TvTableViewCell
        {
            cell.categoryLabel.text = categoryName[indexPath.item]
            cell.configure(with: tv[indexPath.item])
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}

extension TvViewController: TvDelegate {
    func didSelectItem(tv: Tv) {
        print(tv.id)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyBoard.instantiateViewController(withIdentifier: DetailTvViewController.identifier) as? DetailTvViewController {
            detailVC.tvId = tv.id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
