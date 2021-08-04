//
//  MovieTvRepository.swift
//  Movieee
//
//  Created by Sholi on 11/07/21.
//

import Foundation
import Combine

protocol MovieTvRepositoryProtocol {
    func getMovies(type: MovieType.RawValue) -> AnyPublisher<[Movie], Error>
    func getDetailMovie(id: Int) -> AnyPublisher<[DetailMovie], Error>
    
    func getTvs(type: TvType.RawValue) -> AnyPublisher<[Tv], Error>
    func getDetailTv(id: Int) -> AnyPublisher<[DetailTv], Error>
}

final class MovieTvRepository: NSObject {
    typealias MovieTvInstance = (LocalDataSource, RemoteDataSource) -> MovieTvRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataSource
    
    private init(local: LocalDataSource, remote: RemoteDataSource) {
        self.remote = remote
        self.local = local
    }
    
    static let sharedInstance: MovieTvInstance = { localRepo, remoteRepo in
        return MovieTvRepository(local: localRepo, remote: remoteRepo)
    }
}

extension MovieTvRepository: MovieTvRepositoryProtocol {
    
    func getMovies(type: MovieType.RawValue) -> AnyPublisher<[Movie], Error> {
        return self.local.getMovies(type: type)
            .flatMap { result -> AnyPublisher<[Movie], Error> in
                if result.isEmpty {
                    return self.remote.getMovies(type: type)
                        .map { DataMapper.mapMovieResponseToEntity(input: $0) }
                        .flatMap { self.local.addMovies(movies: $0, type: type) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getMovies(type: type)
                        .map { DataMapper.mapMovieEntityToDomain(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.local.getMovies(type: type)
                        .map { DataMapper.mapMovieEntityToDomain(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getDetailMovie(id: Int) -> AnyPublisher<[DetailMovie], Error> {
        
        return self.local.getDetailMovie(id: id)
            .flatMap { result -> AnyPublisher<[DetailMovie], Error> in
                if result.isEmpty {
                    return self.remote.getDetailMovie(id: id)
                        .map { DataMapper.mapDetailMovieResponseToEntity(input: $0) }
                        .flatMap { self.local.addDetailMovie(movie: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getDetailMovie(id: id)
                            .map { [DataMapper.mapDetailMovieEntityToDomain(input: $0[0])] }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.local.getDetailMovie(id: id)
                        .map { [DataMapper.mapDetailMovieEntityToDomain(input: $0[0])] }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getTvs(type: TvType.RawValue) -> AnyPublisher<[Tv], Error> {
        return self.local.getTvs(type: type)
            .flatMap { result -> AnyPublisher<[Tv], Error> in
                if result.isEmpty {
                    return self.remote.getTvs(type: type)
                        .map { DataMapper.mapTvResponseToEntity(input: $0) }
                        .flatMap { self.local.addTvs(tvs: $0, type: type) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getTvs(type: type)
                        .map { DataMapper.mapTvEntityToDomain(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.local.getTvs(type: type)
                        .map { DataMapper.mapTvEntityToDomain(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func getDetailTv(id: Int) -> AnyPublisher<[DetailTv], Error> {
        return self.local.getDetailTv(id: id)
            .flatMap { result -> AnyPublisher<[DetailTv], Error> in
                if result.isEmpty {
                    return self.remote.getDetailTv(id: id)
                        .map { DataMapper.mapDetailTvResponseToEntity(input: $0) }
                        .flatMap { self.local.addDetailTv(tv: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.local.getDetailTv(id: id)
                        .map { [DataMapper.mapDetailTvEntityToDomain(input: $0[0])] }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.local.getDetailTv(id: id)
                        .map { [DataMapper.mapDetailTvEntityToDomain(input: $0[0])] }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
