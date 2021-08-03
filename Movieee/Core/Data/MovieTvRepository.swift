//
//  MovieTvRepository.swift
//  Movieee
//
//  Created by Sholi on 11/07/21.
//

import Foundation

protocol MovieTvRepositoryProtocol {
    func getMovies(type: MovieType.RawValue, result: @escaping (Result<[Movie], Error>) -> Void)
    func getDetailMovie(id: Int, result: @escaping (Result<DetailMovie, Error>) -> Void)
    
    func getTvs(type: TvType.RawValue, result: @escaping (Result<[Tv], Error>) -> Void)
    func getDetailTv(id: Int, result: @escaping (Result<DetailTv, Error>) -> Void)
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
    
    func getMovies(type: MovieType.RawValue, result: @escaping (Result<[Movie], Error>) -> Void){
        local.getMovies(type: type) { localeResponses in
            switch localeResponses {
            case .success(let movieEntity):
                let movieList = DataMapper.mapMovieEntityToDomain(input: movieEntity)
                if movieList.isEmpty {
                    self.remote.getMovies(type: type) { remoteResponses in
                        switch remoteResponses {
                        case .success(let movieResponses):
                            let movieEntities = DataMapper.mapMovieResponseToEntity(input: movieResponses)
                            self.local.addMovies(movies: movieEntities, type: type) { addState in
                                switch addState {
                                case .success(let resultFromAdd):
                                    if resultFromAdd {
                                        self.local.getMovies(type: type) { localeResponses in
                                            switch localeResponses {
                                            case .success(let movieEntity):
                                                let resultList = DataMapper.mapMovieEntityToDomain(input: movieEntity)
                                                result(.success(resultList))
                                            case .failure(let error):
                                                result(.failure(error))
                                            }
                                        }
                                    }
                                case .failure(let error):
                                    result(.failure(error))
                                }
                            }
                        case .failure(let error):
                            result(.failure(error))
                        }
                    }
                } else {
                    result(.success(movieList))
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func getDetailMovie(id: Int, result: @escaping (Result<DetailMovie, Error>) -> Void){
        local.getDetailMovie(id: id) { localeResponses in
            switch localeResponses {
            case .success(let detailMovieEntity):
                if detailMovieEntity.isEmpty {
                    self.remote.getDetailMovie(id: id) { remoteResponses in
                        switch remoteResponses {
                        case .success(let detailMovieResponse):
                            let detailMovieEntity = DataMapper.mapDetailMovieResponseToEntity(input: detailMovieResponse)
                            self.local.addDetailMovie(movie: detailMovieEntity) { addState in
                                switch addState {
                                case .success(let resultFromAdd):
                                    if resultFromAdd {
                                        self.local.getDetailMovie(id: id) { localeResponses in
                                            switch localeResponses {
                                            case .success(let movieEntity):
                                                let resultList = DataMapper.mapDetailMovieEntityToDomain(input: movieEntity[0])
                                                result(.success(resultList))
                                            case .failure(let error):
                                                result(.failure(error))
                                            }
                                        }
                                    }
                                case .failure(let error):
                                    result(.failure(error))
                                }
                            }
                        case .failure(let error):
                            result(.failure(error))
                        }
                    }
                } else {
                    let movieList = DataMapper.mapDetailMovieEntityToDomain(input: detailMovieEntity[0])
                    result(.success(movieList))
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func getTvs(type: TvType.RawValue, result: @escaping (Result<[Tv], Error>) -> Void){
        local.getTvs(type: type) { localeResponses in
            switch localeResponses {
            case .success(let tvEntity):
                let movieList = DataMapper.mapTvEntityToDomain(input: tvEntity)
                if movieList.isEmpty {
                    self.remote.getTvs(type: type) { remoteResponses in
                        switch remoteResponses {
                        case .success(let tvResponses):
                            let tvEntities = DataMapper.mapTvResponseToEntity(input: tvResponses)
                            self.local.addTvs(tvs: tvEntities, type: type) { addState in
                                switch addState {
                                case .success(let resultFromAdd):
                                    if resultFromAdd {
                                        self.local.getTvs(type: type) { localeResponses in
                                            switch localeResponses {
                                            case .success(let tvEntity):
                                                let resultList = DataMapper.mapTvEntityToDomain(input: tvEntity)
                                                result(.success(resultList))
                                            case .failure(let error):
                                                result(.failure(error))
                                            }
                                        }
                                    }
                                case .failure(let error):
                                    result(.failure(error))
                                }
                            }
                        case .failure(let error):
                            result(.failure(error))
                        }
                    }
                } else {
                    result(.success(movieList))
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func getDetailTv(id: Int, result: @escaping (Result<DetailTv, Error>) -> Void){
        local.getDetailTv(id: id) { localeResponses in
            switch localeResponses {
            case .success(let detailTvEntity):
                if detailTvEntity.isEmpty {
                    self.remote.getDetailTv(id: id) { remoteResponses in
                        switch remoteResponses {
                        case .success(let detailTvResponse):
                            let detailTvEntity = DataMapper.mapDetailTvResponseToEntity(input: detailTvResponse)
                            self.local.addDetailTv(tv: detailTvEntity) { addState in
                                switch addState {
                                case .success(let resultFromAdd):
                                    if resultFromAdd {
                                        self.local.getDetailTv(id: id) { localeResponses in
                                            switch localeResponses {
                                            case .success(let tvEntity):
                                                let resultList = DataMapper.mapDetailTvEntityToDomain(input: tvEntity[0])
                                                result(.success(resultList))
                                            case .failure(let error):
                                                result(.failure(error))
                                            }
                                        }
                                    }
                                case .failure(let error):
                                    result(.failure(error))
                                }
                            }
                        case .failure(let error):
                            result(.failure(error))
                        }
                    }
                } else {
                    let movieList = DataMapper.mapDetailTvEntityToDomain(input: detailTvEntity[0])
                    result(.success(movieList))
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
