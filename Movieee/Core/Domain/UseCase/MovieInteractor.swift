//
//  HomeInteractor.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation

protocol MovieUseCase {
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    func getTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    func getNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieInteractor: MovieUseCase {
    
    private let repository: MovieTvRepositoryProtocol
    
    required init(repository: MovieTvRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        repository.getPopularMovies { result in
            completion(result)
        }
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        repository.getTopRatedMovies { result in
            completion(result)
        }
    }
    
    func getNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        repository.getNowPlayingMovies { result in
            completion(result)
        }
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        repository.getUpcomingMovies() { result in
            completion(result)
        }
    }
    
}
