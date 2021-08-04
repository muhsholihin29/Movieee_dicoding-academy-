//
//  DetailMoviePresenter.swift
//  DetailMoviePresenter
//
//  Created by Sholi on 31/07/21.
//

import Foundation
import Combine

class DetailMoviePresenter: ObservableObject {
    let detailUseCase: MovieUseCase
    
    enum State {
        case isLoading
        case failed
        case loaded
    }
    
    private var cancellables: Set<AnyCancellable> = []
    @Published var detailMovie: DetailMovie?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    @Published private(set) var state = State.isLoading
    
    init(detailUseCase: MovieUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getDetailMovie(id: Int) {
        self.loadingState = true
        detailUseCase.getDetailMovie(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { detailMovie in
                if (!detailMovie.isEmpty){
                    self.detailMovie = detailMovie.first
                }
            })
            .store(in: &cancellables)
    }
}
