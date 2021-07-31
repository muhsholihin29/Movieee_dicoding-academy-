//
//  RemoteDataSource.swift
//  Movieee
//
//  Created by Sholi on 11/07/21.
//

import Foundation

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
        
        let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
            if maybeError != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let games = try decoder.decode(MovieResponse.self, from: data).results
                    result(.success(games))
                } catch let error {
                    print(error)
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(result: @escaping (Result<[MovieResponse.Result], URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.topRatedMovies.url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
            if maybeError != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let games = try decoder.decode(MovieResponse.self, from: data).results
                    result(.success(games))
                } catch let error {
                    print(error)
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(result: @escaping (Result<[MovieResponse.Result], URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.upcomingMovies.url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
            if maybeError != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let games = try decoder.decode(MovieResponse.self, from: data).results
                    result(.success(games))
                } catch let error {
                    print(error)
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    func getNowPlayingMovies(result: @escaping (Result<[MovieResponse.Result], URLError>) -> Void) {
        guard let url = URL(string: Endpoints.Gets.nowPlayingMovies.url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
            if maybeError != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let games = try decoder.decode(MovieResponse.self, from: data).results
                    
                    result(.success(games))
                } catch let error {
                    print(error)
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    func getDetailMovie(
        id: Int,
        result: @escaping (Result<DetailMovieResponse, URLError>) -> Void
    ) {
        
        guard let url = URL(string: Endpoints.Gets.detailMovie(id: id).url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
            if maybeError != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let games = try decoder.decode(DetailMovieResponse.self, from: data)
                    result(.success(games))
                } catch let error {
                    print(error)
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    func getPopularTv(
        result: @escaping (Result<[TvResponse.Result], URLError>) -> Void
    ) {
        guard let url = URL(string: Endpoints.Gets.popularTv.url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
            if maybeError != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let games = try decoder.decode(TvResponse.self, from: data).results
                    result(.success(games))
                } catch let error {
                    print(error)
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    func getTopRatedTv(
        result: @escaping (Result<[TvResponse.Result], URLError>) -> Void
    ) {
        guard let url = URL(string: Endpoints.Gets.topRatedTv.url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
            if maybeError != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let games = try decoder.decode(TvResponse.self, from: data).results
                    result(.success(games))
                } catch let error {
                    print(error)
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    func getAiringTodayTv(
        result: @escaping (Result<[TvResponse.Result], URLError>) -> Void
    ) {
        guard let url = URL(string: Endpoints.Gets.airingTodayTv.url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
            if maybeError != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let games = try decoder.decode(TvResponse.self, from: data).results
                    result(.success(games))
                } catch let error {
                    print(error)
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    func getOnTheAirTv(
        result: @escaping (Result<[TvResponse.Result], URLError>) -> Void
    ) {
        guard let url = URL(string: Endpoints.Gets.onTheAirTv.url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
            if maybeError != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let games = try decoder.decode(TvResponse.self, from: data).results
                    result(.success(games))
                } catch let error {
                    print(error)
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
    func getDetailTv(
        id: Int,
        result: @escaping (Result<DetailTvResponse, URLError>) -> Void
    ) {
        guard let url = URL(string: Endpoints.Gets.detailTv(id: id).url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, maybeError in
            if maybeError != nil {
                result(.failure(.addressUnreachable(url)))
            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    let detail = try decoder.decode(DetailTvResponse.self, from: data)
                    result(.success(detail))
                } catch let error {
                    print(error)
                    result(.failure(.invalidResponse))
                }
            }
        }
        task.resume()
    }
    
}
