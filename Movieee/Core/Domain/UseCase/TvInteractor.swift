//
//  HomeInteractor.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation

protocol TvUseCase {
    func getTvs(type: TvType.RawValue, completion: @escaping (Result<[Tv], Error>) -> Void) 
        
    func getPopularTv(completion: @escaping (Result<[Tv], Error>) -> Void)
    func getTopRatedTv(completion: @escaping (Result<[Tv], Error>) -> Void)
    func getOnTheAirTv(completion: @escaping (Result<[Tv], Error>) -> Void)
    func getAiringTodayTv(completion: @escaping (Result<[Tv], Error>) -> Void)
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
    
    func getPopularTv(completion: @escaping (Result<[Tv], Error>) -> Void) {
        repository.getPopularTv() { result in
            completion(result)
        }
    }
    
    func getTopRatedTv(completion: @escaping (Result<[Tv], Error>) -> Void) {
        repository.getTopRatedTv() { result in
            completion(result)
        }
    }
    
    func getOnTheAirTv(completion: @escaping (Result<[Tv], Error>) -> Void) {
        repository.getOnTheAirTv() { result in
            completion(result)
        }
    }
    
    func getAiringTodayTv(completion: @escaping (Result<[Tv], Error>) -> Void) {
        repository.getAiringTodayTv() { result in
            completion(result)
        }
    }
    
    
}

