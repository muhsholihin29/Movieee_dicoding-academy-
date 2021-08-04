//
//  HomePresenter.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation
import Combine

class TvPresenter: ObservableObject {
    
    let tvUseCase: TvUseCase
    
    enum State {
        case isLoading
        case failed
        case loaded
    }
    
    private var cancellables: Set<AnyCancellable> = []
    @Published var tv = [[Tv]](repeating: [], count: 4)
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    @Published private(set) var state = State.isLoading
    
    init(tvUseCase: TvUseCase) {
        self.tvUseCase = tvUseCase
    }
    
    func getPopularTv() {
        self.loadingState = true
        
        tvUseCase.getTvs(type: TvType.POPULAR.rawValue) .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { tv in
                self.tv[0] = tv
                
            })
            .store(in: &cancellables)
    }
    
    func getTopRatedTv() {
        self.loadingState = true
        
        tvUseCase.getTvs(type: TvType.TOP_RATED.rawValue) .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.errorMessage = String(describing: completion)
            case .finished:
                self.loadingState = false
            }
        }, receiveValue: { tv in
            self.tv[1] = tv
            
        })
            .store(in: &cancellables)
    }
    
    func getAiringTodayTv() {
        
        tvUseCase.getTvs(type: TvType.AIRING_TODAY.rawValue)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { tv in
                self.tv[2] = tv
                
            })
            .store(in: &cancellables)
    }
    
    func getOnTheAirTv() {
        
        tvUseCase.getTvs(type: TvType.ON_THE_AIR.rawValue) .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                self.errorMessage = String(describing: completion)
            case .finished:
                self.loadingState = false
            }
        }, receiveValue: { tv in
            self.tv[3] = tv
            
        })
            .store(in: &cancellables)
    }
}
