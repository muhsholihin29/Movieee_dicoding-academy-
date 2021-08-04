//
//  HomeInteractor.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation
import RxSwift

protocol TvUseCase {
    func getTvs(type: TvType.RawValue) -> Observable<[Tv]>
    func getDetailTv(id: Int) -> Observable<[DetailTv]>
}

class TvInteractor: TvUseCase {
    
    private let repository: MovieTvRepositoryProtocol
    
    required init(repository: MovieTvRepositoryProtocol) {
        self.repository = repository
    }

    func getTvs(type: TvType.RawValue) -> Observable<[Tv]>  {
        return repository.getTvs(type: type)
    }
    
    func getDetailTv(id: Int) -> Observable<[DetailTv]>  {
        return repository.getDetailTv(id: id)
    }
}

