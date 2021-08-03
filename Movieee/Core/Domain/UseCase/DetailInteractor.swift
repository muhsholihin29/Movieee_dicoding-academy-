//
//  DetailInteractor.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation

protocol DetailUseCase{
    func getDetailMovie(id: Int, completion: @escaping (Result<DetailMovie, Error>) -> Void)
    func getDetailTv(id: Int, completion: @escaping (Result<DetailTv, Error>) -> Void)
}

class DetailInteractor: DetailUseCase {
    
    private let repository: MovieTvRepositoryProtocol
    
    required init(repository: MovieTvRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDetailMovie(id: Int, completion: @escaping (Result<DetailMovie, Error>) -> Void) {
        repository.getDetailMovie(id: id) { result in
            completion(result)
        }
    }
    
    func getDetailTv(id: Int, completion: @escaping (Result<DetailTv, Error>) -> Void) {
        repository.getDetailTv(id: id) { result in
            completion(result)
        }
    }
    
}
