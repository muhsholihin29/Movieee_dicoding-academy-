//
//  DetailTvPresenter.swift
//  DetailTvPresenter
//
//  Created by Sholi on 31/07/21.
//

import Foundation
import RxSwift

class DetailTvPresenter: ObservableObject {
    let detailUseCase: TvUseCase
    
    enum State {
        case isLoading
        case failed
        case loaded
    }
    
    private let disposeBag = DisposeBag()
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
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                if (!result.isEmpty){
                    self.detailTv = result.first
                }
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
}
