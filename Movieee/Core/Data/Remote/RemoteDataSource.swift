//
//  RemoteDataSource.swift
//  Movieee
//
//  Created by Sholi on 11/07/21.
//

import Foundation
import Alamofire

protocol RemoteDataSourceProtocol: class {
    
    func getPopularMovies(result: @escaping (Result<[MovieResponse.Result], URLError>) -> Void)
    func getTopRatedMovies(result: @escaping (Result<[MovieResponse.Result], URLError>) -> Void)
    func getNowPlayingMovies(result: @escaping (Result<[MovieResponse.Result], URLError>) -> Void)
    func getUpcomingMovies(result: @escaping (Result<[MovieResponse.Result], URLError>) -> Void)
    func getDetailMovie(id: Int, result: @escaping (Result<DetailMovieResponse, URLError>) -> Void)
    
    func getPopularTv(result: @escaping (Result<[TvResponse.Result], URLError>) -> Void)
    func getTopRatedTv(result: @escaping (Result<[TvResponse.Result], URLError>) -> Void)
    func getOnTheAirTv(result: @escaping (Result<[TvResponse.Result], URLError>) -> Void)
    func getAiringTodayTv(result: @escaping (Result<[TvResponse.Result], URLError>) -> Void)
    func getDetailTv(id: Int, result: @escaping (Result<DetailTvResponse, URLError>) -> Void)
    
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getPopularMovies(result: @escaping (Result<[MovieResponse.Result], URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.popularMovies.url) else { return }
        
        AF.request(url).validate().responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value.results))
            case .failure:
                result(.failure(.invalidResponse))
            }
        }
    }
    
    func getTopRatedMovies(result: @escaping (Result<[MovieResponse.Result], URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.topRatedMovies.url) else { return }
        
        AF.request(url).validate().responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value.results))
            case .failure:
                result(.failure(.invalidResponse))
            }
        }
    }
    
    func getUpcomingMovies(result: @escaping (Result<[MovieResponse.Result], URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.upcomingMovies.url) else { return }
        
        AF.request(url).validate().responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value.results))
            case .failure:
                result(.failure(.invalidResponse))
            }
        }
    }
    
    func getNowPlayingMovies(result: @escaping (Result<[MovieResponse.Result], URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.nowPlayingMovies.url) else { return }
        
        AF.request(url).validate().responseDecodable(of: MovieResponse.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value.results))
            case .failure:
                result(.failure(.invalidResponse))
            }
        }
    }
    
    func getDetailMovie(
        id: Int,
        result: @escaping (Result<DetailMovieResponse, URLError>) -> Void
    ) {
        
        guard let url = URL(string: Endpoints.Gets.detailMovie(id: id).url) else { return }
        
        AF.request(url).validate().responseDecodable(of: DetailMovieResponse.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value))
            case .failure:
                result(.failure(.invalidResponse))
            }
        }
    }
    
    func getPopularTv(
        result: @escaping (Result<[TvResponse.Result], URLError>) -> Void
    ) {
        guard let url = URL(string: Endpoints.Gets.popularTv.url) else { return }
        
        AF.request(url).validate().responseDecodable(of: TvResponse.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value.results))
            case .failure:
                result(.failure(.invalidResponse))
            }
        }
    }
    
    func getTopRatedTv(
        result: @escaping (Result<[TvResponse.Result], URLError>) -> Void
    ) {
        guard let url = URL(string: Endpoints.Gets.topRatedTv.url) else { return }
        
        AF.request(url).validate().responseDecodable(of: TvResponse.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value.results))
            case .failure:
                result(.failure(.invalidResponse))
            }
        }
    }
    
    func getAiringTodayTv(
        result: @escaping (Result<[TvResponse.Result], URLError>) -> Void
    ) {
        guard let url = URL(string: Endpoints.Gets.airingTodayTv.url) else { return }
        
        AF.request(url).validate().responseDecodable(of: TvResponse.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value.results))
            case .failure:
                result(.failure(.invalidResponse))
            }
        }
    }
    
    func getOnTheAirTv(
        result: @escaping (Result<[TvResponse.Result], URLError>) -> Void
    ) {
        guard let url = URL(string: Endpoints.Gets.onTheAirTv.url) else { return }
        
        AF.request(url).validate().responseDecodable(of: TvResponse.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value.results))
            case .failure:
                result(.failure(.invalidResponse))
            }
        }
    }
    
    func getDetailTv(
        id: Int,
        result: @escaping (Result<DetailTvResponse, URLError>) -> Void
    ) {
        guard let url = URL(string: Endpoints.Gets.detailTv(id: id).url) else { return }
        
        AF.request(url).validate().responseDecodable(of: DetailTvResponse.self) { response in
            switch response.result {
            case .success(let value):
                result(.success(value))
            case .failure:
                result(.failure(.invalidResponse))
            }
        }
    }
    
}
