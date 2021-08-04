//
//  HomePresenter.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation
import Combine

class MoviePresenter: ObservableObject {
    
    let movieUseCase: MovieUseCase
    
    enum State {
        case isLoading
        case failed
        case loaded
    }
    
    private var cancellables: Set<AnyCancellable> = []
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
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { movies in
                    self.movies[0] = movies
                
            })
            .store(in: &cancellables)
    }
    
    func getTopRatedMovies() {
        
        movieUseCase.getMovies(type: MovieType.TOP_RATED.rawValue)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { movies in
                self.movies[1] = movies
                
            })
            .store(in: &cancellables)
    }
    
    func getNowPlayingMovies() {
        
        movieUseCase.getMovies(type: MovieType.NOW_PLAYING.rawValue) .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { movies in
                self.movies[2] = movies
                
            })
            .store(in: &cancellables)
    }
    
    func getUpcomingMovies() {
        
        movieUseCase.getMovies(type: MovieType.UPCOMING.rawValue) .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { movies in
                self.movies[3] = movies
                
            })
            .store(in: &cancellables)
    }
}
