//
//  HomeInteractor.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation
import Combine

protocol TvUseCase {
    func getTvs(type: TvType.RawValue) -> AnyPublisher<[Tv], Error>
    func getDetailTv(id: Int) -> AnyPublisher<[DetailTv], Error>
}

class TvInteractor: TvUseCase {
    
    private let repository: MovieTvRepositoryProtocol
    
    required init(repository: MovieTvRepositoryProtocol) {
        self.repository = repository
    }
    
    func getTvs(type: TvType.RawValue) -> AnyPublisher<[Tv], Error> {
        repository.getTvs(type: type)
    }
    
    func getDetailTv(id: Int) -> AnyPublisher<[DetailTv], Error> {
        repository.getDetailTv(id: id)
    }
}

