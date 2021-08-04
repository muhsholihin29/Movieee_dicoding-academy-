//
//  DetailTvPresenter.swift
//  DetailTvPresenter
//
//  Created by Sholi on 31/07/21.
//

import Foundation
import Combine

class DetailTvPresenter: ObservableObject {
    let detailUseCase: TvUseCase
    
    enum State {
        case isLoading
        case failed
        case loaded
    }
    
    private var cancellables: Set<AnyCancellable> = []
    @Published var detailTv: DetailTv?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    @Published private(set) var state = State.isLoading
    
    init(detailUseCase: TvUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getDetailTv(id: Int) {
        self.loadingState = true
        
        detailUseCase.getDetailTv(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { detailTv in
                if (!detailTv.isEmpty){
                    self.detailTv = detailTv.first
                }
            })
            .store(in: &cancellables)
    }
}
