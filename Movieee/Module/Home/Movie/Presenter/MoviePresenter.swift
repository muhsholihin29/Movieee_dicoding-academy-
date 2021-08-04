//
//  HomePresenter.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation
import RxSwift

@propertyWrapper
struct Published<Value> {
    var projectedValue: Observable<Value> { subject }
    var wrappedValue: Value { didSet { valueDidChange() } }
    
    private let subject = PublishSubject<Value>()
    
    init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
    private func valueDidChange() {
        subject.on(.next(wrappedValue))
    }
}
class MoviePresenter: ObservableObject {
    
    let movieUseCase: MovieUseCase
    
    enum State {
        case isLoading
        case failed
        case loaded
    }
    
    private let disposeBag = DisposeBag()
    @Published var movies = [[Movie]](repeating: [], count: 4)
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    @Published private(set) var state = State.isLoading
    
    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
    }
    
    func getPopularMovies() {
        self.loadingState = true
        
        movieUseCase.getMovies(type: MovieType.POPULAR.rawValue)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.movies[0] = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
                print("error \(error.localizedDescription)")
            } onCompleted: {
                
            }.disposed(by: disposeBag)
    }
    
    func getTopRatedMovies() {
        
        movieUseCase.getMovies(type: MovieType.TOP_RATED.rawValue)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.movies[1] = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                
            }.disposed(by: disposeBag)
    }
    
    func getNowPlayingMovies() {
        
        movieUseCase.getMovies(type: MovieType.NOW_PLAYING.rawValue)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.movies[2] = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                
            }.disposed(by: disposeBag)
    }
    
    func getUpcomingMovies() {
        
        movieUseCase.getMovies(type: MovieType.UPCOMING.rawValue)
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.movies[3] = result
            } onError: { error in
                self.errorMessage = error.localizedDescription
            } onCompleted: {
                self.state = State.loaded
                self.loadingState = false
            }.disposed(by: disposeBag)
    }
}
