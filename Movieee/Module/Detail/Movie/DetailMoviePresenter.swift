//
//  DetailMoviePresenter.swift
//  DetailMoviePresenter
//
//  Created by Sholi on 31/07/21.
//

import Foundation
import RxSwift

class DetailMoviePresenter: ObservableObject {
    let detailUseCase: MovieUseCase
    
    enum State {
        case isLoading
        case failed
        case loaded
    }
    
    private let disposeBag = DisposeBag()
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
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                if (!result.isEmpty){
                    self.detailMovie = result.first
                }
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
}
