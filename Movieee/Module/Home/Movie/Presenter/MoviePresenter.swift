//
//  HomePresenter.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation

class MoviePresenter: ObservableObject {
    
    let movieUseCase: MovieUseCase
    
    enum State {
        case isLoading
        case failed
        case loaded
    }
    
    
    @Published var movies = [[Movie]](repeating: [], count: 4)
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = true
    
    @Published private(set) var state = State.isLoading
    
    init(movieUseCase: MovieUseCase) {
        self.movieUseCase = movieUseCase
    }
    
    func getPopularMovies() {
        self.loadingState = true
        
        movieUseCase.getMovies(type: MovieType.POPULAR.rawValue) { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.movies[0] = movies
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("errooor")
                }
            }
        }
    }
    
    func getTopRatedMovies() {
        
        movieUseCase.getMovies(type: MovieType.TOP_RATED.rawValue) { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.movies[1] = movies
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("errooor")
                }
            }
        }
    }
    
    func getNowPlayingMovies() {
        
        movieUseCase.getMovies(type: MovieType.NOW_PLAYING.rawValue) { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.movies[2] = movies
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    print("errooor")
                }
            }
        }
    }
    
    func getUpcomingMovies() {
        
        movieUseCase.getMovies(type: MovieType.UPCOMING.rawValue) { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.state = State.loaded
                    self.loadingState = false
                    self.movies[3] = movies 
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
