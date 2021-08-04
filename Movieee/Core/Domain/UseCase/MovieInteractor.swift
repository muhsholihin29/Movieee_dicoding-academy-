//
//  HomeInteractor.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation
import Combine

protocol MovieUseCase {
    func getMovies(type: MovieType.RawValue) -> AnyPublisher<[Movie], Error>
    func getDetailMovie(id: Int) -> AnyPublisher<[DetailMovie], Error>
}

class MovieInteractor: MovieUseCase {
    
    private let repository: MovieTvRepositoryProtocol
    
    required init(repository: MovieTvRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovies(type: MovieType.RawValue) -> AnyPublisher<[Movie], Error> {
        repository.getMovies(type: type) 
    }
    
    func getDetailMovie(id: Int) -> AnyPublisher<[DetailMovie], Error> {
        repository.getDetailMovie(id: id)
    }
}

