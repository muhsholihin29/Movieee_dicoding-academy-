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
        
        tvUseCase.getPopularTv { result in
            switch result {
            case .success(let tv):
                DispatchQueue.main.async {
                    self.tv[0] = tv
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
        
        tvUseCase.getTopRatedTv { result in
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
        
        tvUseCase.getAiringTodayTv { result in
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
        
        tvUseCase.getOnTheAirTv { result in
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
