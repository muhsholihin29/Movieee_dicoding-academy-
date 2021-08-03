//
//  HomeInteractor.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation

protocol MovieUseCase {
    func getMovies(type: MovieType.RawValue, completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieInteractor: MovieUseCase {
    
    private let repository: MovieTvRepositoryProtocol
    
    required init(repository: MovieTvRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovies(type: MovieType.RawValue, completion: @escaping (Result<[Movie], Error>) -> Void) {
        repository.getMovies(type: type) { result in
            completion(result)
        }
    }
}

