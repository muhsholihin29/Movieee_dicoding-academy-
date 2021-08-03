//
//  HomeInteractor.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation

protocol TvUseCase {
    func getTvs(type: TvType.RawValue, completion: @escaping (Result<[Tv], Error>) -> Void)
}

class TvInteractor: TvUseCase {
    
    private let repository: MovieTvRepositoryProtocol
    
    required init(repository: MovieTvRepositoryProtocol) {
        self.repository = repository
    }
    
    func getTvs(type: TvType.RawValue, completion: @escaping (Result<[Tv], Error>) -> Void) {
        repository.getTvs(type: type) { result in
            completion(result)
        }
    }
}

