//
//  HomePresenter.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation
import RxSwift

class TvPresenter: ObservableObject {
    
    let tvUseCase: TvUseCase
    
    enum State {
        case isLoading
        case failed
        case loaded
    }
    
    private let disposeBag = DisposeBag()
    @Published var tv = [[Tv]](repeating: [], count: 4)
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    @Published private(set) var state = State.isLoading
    
    init(tvUseCase: TvUseCase) {
        self.tvUseCase = tvUseCase
    }
    
    func getPopularTv() {
        self.loadingState = true
        
        tvUseCase.getTvs(type: TvType.POPULAR.rawValue)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.tv[0] = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                
            }.disposed(by: disposeBag)
    }
    
    func getTopRatedTv() {
        
        tvUseCase.getTvs(type: TvType.TOP_RATED.rawValue)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.tv[1] = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                
            }.disposed(by: disposeBag)
    }
    
    func getAiringTodayTv() {
        
        tvUseCase.getTvs(type: TvType.AIRING_TODAY.rawValue)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.tv[2] = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                
            }.disposed(by: disposeBag)
    }
    
    func getOnTheAirTv() {
        
        tvUseCase.getTvs(type: TvType.ON_THE_AIR.rawValue)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.tv[3] = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
}
