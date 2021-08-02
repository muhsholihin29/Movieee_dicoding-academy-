//
//  MovieTvRepository.swift
//  Movieee
//
//  Created by Sholi on 11/07/21.
//

import Foundation

protocol MovieTvRepositoryProtocol {
    func getMovies(type: MovieType.RawValue, result: @escaping (Result<[Movie], Error>) -> Void)
    
    func getPopularMovies(result: @escaping (Result<[Movie], Error>) -> Void)
    func getTopRatedMovies(result: @escaping (Result<[Movie], Error>) -> Void)
    func getNowPlayingMovies(result: @escaping (Result<[Movie], Error>) -> Void)
    func getUpcomingMovies(result: @escaping (Result<[Movie], Error>) -> Void)
    func getDetailMovies(id: Int, result: @escaping (Result<DetailMovie, Error>) -> Void)
    
    func getTvs(type: TvType.RawValue, result: @escaping (Result<[Tv], Error>) -> Void)
    
    func getPopularTv(result: @escaping (Result<[Tv], Error>) -> Void)
    func getTopRatedTv(result: @escaping (Result<[Tv], Error>) -> Void)
    func getOnTheAirTv(result: @escaping (Result<[Tv], Error>) -> Void)
    func getAiringTodayTv(result: @escaping (Result<[Tv], Error>) -> Void)
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
    
    func getPopularMovies(result: @escaping (Result<[Movie], Error>) -> Void){
        self.remote.getPopularMovies { remoteResponses in
            switch remoteResponses {
            case .success(let responses):
                let resultList = DataMapper.mapMovieResponseToDomain(input: responses)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
                print(error)
            }
        }
    }
    
    func getTopRatedMovies(result: @escaping (Result<[Movie], Error>) -> Void) {
        self.remote.getTopRatedMovies { remoteResponses in
            switch remoteResponses {
            case .success(let responses):
                let resultList = DataMapper.mapMovieResponseToDomain(input: responses)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
                print(error)
            }
        }
    }
    
    func getNowPlayingMovies(result: @escaping (Result<[Movie], Error>) -> Void) {
        self.remote.getNowPlayingMovies { remoteResponses in
            switch remoteResponses {
            case .success(let responses):
                let resultList = DataMapper.mapMovieResponseToDomain(input: responses)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
                print(error)
            }
        }
    }
    
    func getUpcomingMovies(result: @escaping (Result<[Movie], Error>) -> Void) {
        self.remote.getUpcomingMovies { remoteResponses in
            switch remoteResponses {
            case .success(let responses):
                let resultList = DataMapper.mapMovieResponseToDomain(input: responses)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
                print(error)
            }
        }
    }
    
    func getDetailMovies(id: Int, result: @escaping (Result<DetailMovie, Error>) -> Void){
        self.remote.getDetailMovie(id: id) { remoteResponses in
            switch remoteResponses {
            case .success(let responses):
                let resultData = DataMapper.mapDetailMovieResponseToDomain(input: responses)
                result(.success(resultData))
            case .failure(let error):
                result(.failure(error))
                print(error)
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
    
    func getPopularTv(result: @escaping (Result<[Tv], Error>) -> Void) {
        self.remote.getPopularTv { remoteResponses in
            switch remoteResponses {
            case .success(let responses):
                let resultList = DataMapper.mapTvResponseToDomain(input: responses)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
                print(error)
            }
        }
    }
    
    func getTopRatedTv(result: @escaping (Result<[Tv], Error>) -> Void) {
        self.remote.getTopRatedTv { remoteResponses in
            switch remoteResponses {
            case .success(let responses):
                let resultList = DataMapper.mapTvResponseToDomain(input: responses)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
                print(error)
            }
        }
    }
    
    func getOnTheAirTv(result: @escaping (Result<[Tv], Error>) -> Void) {
        self.remote.getOnTheAirTv { remoteResponses in
            switch remoteResponses {
            case .success(let responses):
                let resultList = DataMapper.mapTvResponseToDomain(input: responses)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
                print(error)
            }
        }
    }
    
    func getAiringTodayTv(result: @escaping (Result<[Tv], Error>) -> Void) {
        self.remote.getAiringTodayTv { remoteResponses in
            switch remoteResponses {
            case .success(let responses):
                let resultList = DataMapper.mapTvResponseToDomain(input: responses)
                result(.success(resultList))
            case .failure(let error):
                result(.failure(error))
                print(error)
            }
        }
    }
    
    func getDetailTv(id: Int, result: @escaping (Result<DetailTv, Error>) -> Void){
        self.remote.getDetailTv(id: id) { remoteResponses in
            switch remoteResponses {
            case .success(let responses):
                let resultData = DataMapper.mapDetailTvResponseToDomain(input: responses)
                result(.success(resultData))
            case .failure(let error):
                result(.failure(error))
                print(error)
            }
        }
    }
    
    
}
