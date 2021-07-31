//
//  MovieTvRepository.swift
//  Movieee
//
//  Created by Sholi on 11/07/21.
//

import Foundation

protocol MovieTvRepositoryProtocol {
    func getPopularMovies(result: @escaping (Result<[Movie], Error>) -> Void)
    func getTopRatedMovies(result: @escaping (Result<[Movie], Error>) -> Void)
    func getNowPlayingMovies(result: @escaping (Result<[Movie], Error>) -> Void)
    func getUpcomingMovies(result: @escaping (Result<[Movie], Error>) -> Void)
    func getDetailMovies(id: Int, result: @escaping (Result<DetailMovie, Error>) -> Void)
    
    func getPopularTv(result: @escaping (Result<[Tv], Error>) -> Void)
    func getTopRatedTv(result: @escaping (Result<[Tv], Error>) -> Void)
    func getOnTheAirTv(result: @escaping (Result<[Tv], Error>) -> Void)
    func getAiringTodayTv(result: @escaping (Result<[Tv], Error>) -> Void)
    func getDetailTv(id: Int, result: @escaping (Result<DetailTv, Error>) -> Void)
}

final class MovieTvRepository: NSObject {
    typealias MovieTvInstance = (RemoteDataSource) -> MovieTvRepository
    
    fileprivate let remote: RemoteDataSource
    
    private init(remote: RemoteDataSource) {
        self.remote = remote
    }
    
    static let sharedInstance: MovieTvInstance = { remoteRepo in
        return MovieTvRepository(remote: remoteRepo)
    }
}

extension MovieTvRepository: MovieTvRepositoryProtocol {
    
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