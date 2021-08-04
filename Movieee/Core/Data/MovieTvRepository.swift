//
//  MovieTvRepository.swift
//  Movieee
//
//  Created by Sholi on 11/07/21.
//

import Foundation
import RxSwift

protocol MovieTvRepositoryProtocol {
    func getMovies(type: MovieType.RawValue) -> Observable<[Movie]>
    func getDetailMovie(id: Int) -> Observable<[DetailMovie]>
    
    func getTvs(type: TvType.RawValue) -> Observable<[Tv]>
    func getDetailTv(id: Int) -> Observable<[DetailTv]>
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
    
    func getMovies(type: MovieType.RawValue) -> Observable<[Movie]> {
        return self.local.getMovies(type: type)
            .map {
                return DataMapper.mapMovieEntityToDomain(input: $0)
            }
            .filter { !$0.isEmpty }
            .ifEmpty(switchTo: self.remote.getMovies(type: type)
                .map { DataMapper.mapMovieResponseToEntity(input: $0) }
                .flatMap { self.local.addMovies(movies: $0, type: type)}
                .filter {$0}
                .flatMap { _ in self.local.getMovies(type: type)
                    .map { DataMapper.mapMovieEntityToDomain(input: $0) }
                }
            )
    }
    
    func getDetailMovie(id: Int) -> Observable<[DetailMovie]> {
        return local.getDetailMovie(id: id)

            .map {_ in []
            }
            .ifEmpty(switchTo: self.remote.getDetailMovie(id: id)
                .map { DataMapper.mapDetailMovieResponseToEntity(input: $0) }
                .flatMap { self.local.addDetailMovie(movie: $0)}
                .filter {$0}
                .flatMap { _ in self.local.getDetailMovie(id: id)
                    .map {
                        print("output")
                        return [DataMapper.mapDetailMovieEntityToDomain(input: $0[0])] }
                }
            )
    }
    
    func getTvs(type: TvType.RawValue) -> Observable<[Tv]> {
        return local.getTvs(type: type)
        
            .ifEmpty(switchTo: self.remote.getTvs(type: type)
                        .map { DataMapper.mapTvResponseToEntity(input: $0) }
                        .flatMap { self.local.addTvs(tvs: $0, type: type)}
                        .filter {$0}
                        .flatMap { _ in self.local.getTvs(type: type)}
            )
            .map {
                DataMapper.mapTvEntityToDomain(input: $0)
            }
    }
    
    func getDetailTv(id: Int) -> Observable<[DetailTv]> {
        
        return local.getDetailTv(id: id)
            .map {
                if($0.isEmpty){
                    return []
                }else{
                    return [DataMapper.mapDetailTvEntityToDomain(input: $0[0])]
                }
            }
            .ifEmpty(switchTo: self.remote.getDetailTv(id: id)
                .map { DataMapper.mapDetailTvResponseToEntity(input: $0) }
                .flatMap { self.local.addDetailTv(tv: $0)}
                .filter {$0}
                .flatMap { _ in self.local.getDetailTv(id: id)
                    .map { [DataMapper.mapDetailTvEntityToDomain(input: $0[0])] }
                }
            )
            
    }
}
