//
//  HomePresenter.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation

class TvPresenter: ObservableObject {
    
    let tvUseCase: TvUseCase
    
    enum State {
        case isLoading
        case failed
        case loaded
    }
    
    
    @Published var tv = [[Tv]](repeating: [], count: 4)
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    @Published private(set) var state = State.isLoading
    
    init(tvUseCase: TvUseCase) {
        self.tvUseCase = tvUseCase
    }
    
    func getPopularTv() {
        self.loadingState = true
        
        tvUseCase.getTvs(type: TvType.POPULAR.rawValue) { result in
            switch result {
            case .success(let tv):
                DispatchQueue.main.async {
                    self.tv[0] = tv
                    print("mytag \(tv[0].id)")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("errooor")
                }
            }
        }
    }
    
    func getTopRatedTv() {
        self.loadingState = true
        
        tvUseCase.getTvs(type: TvType.TOP_RATED.rawValue) { result in
            switch result {
            case .success(let tv):
                DispatchQueue.main.async {
                    self.tv[1] = tv
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("errooor")
                }
            }
        }
    }
    
    func getAiringTodayTv() {
        
        tvUseCase.getTvs(type: TvType.AIRING_TODAY.rawValue) { result in
            switch result {
            case .success(let tv):
                DispatchQueue.main.async {
                    self.tv[2] = tv
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("errooor")
                }
            }
        }
    }
    
    func getOnTheAirTv() {
        
        tvUseCase.getTvs(type: TvType.ON_THE_AIR.rawValue) { result in
            switch result {
            case .success(let tv):
                DispatchQueue.main.async {
                    self.state = State.loaded
                    self.loadingState = false
                    self.tv[3] = tv
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.loadingState = false
                    self.errorMessage = error.localizedDescription
                    print("errooor")
                }
            }
        }
    }
}
