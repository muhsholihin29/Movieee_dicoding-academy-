//
//  DetailMoviePresenter.swift
//  DetailMoviePresenter
//
//  Created by Sholi on 31/07/21.
//

import Foundation

class DetailMoviePresenter: ObservableObject {
    let detailUseCase: DetailUseCase
    
    enum State {
        case isLoading
        case failed
        case loaded
    }
    
    
    @Published var detailMovie: DetailMovie?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    @Published private(set) var state = State.isLoading
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getDetailMovie(id: Int) {
        self.loadingState = true
        
        detailUseCase.getDetailMovie(id: id) { result in
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    self.state = State.loaded
                    self.loadingState = false
                    self.detailMovie = movie
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
