//
//  DetailTvPresenter.swift
//  DetailTvPresenter
//
//  Created by Sholi on 31/07/21.
//

import Foundation

class DetailTvPresenter: ObservableObject {
    let detailUseCase: DetailUseCase
    
    enum State {
        case isLoading
        case failed
        case loaded
    }
    
    
    @Published var detailTv: DetailTv?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    @Published private(set) var state = State.isLoading
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getDetailTv(id: Int) {
        self.loadingState = true
        
        detailUseCase.getDetailTv(id: id) { result in
            switch result {
            case .success(let tv):
                DispatchQueue.main.async {
                    self.state = State.loaded
                    self.loadingState = false
                    self.detailTv = tv
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
