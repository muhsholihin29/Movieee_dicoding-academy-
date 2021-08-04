//
//  HomeInteractor.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation
import RxSwift

protocol MovieUseCase {
    func getMovies(type: MovieType.RawValue) -> Observable<[Movie]>
    func getDetailMovie(id: Int) -> Observable<[DetailMovie]>
}

class MovieInteractor: MovieUseCase {
    
    private let repository: MovieTvRepositoryProtocol
    
    required init(repository: MovieTvRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovies(type: MovieType.RawValue) -> Observable<[Movie]> {
        return repository.getMovies(type: type)
    }
    
    func getDetailMovie(id: Int) -> Observable<[DetailMovie]>  {
        return repository.getDetailMovie(id: id)
    }
}

