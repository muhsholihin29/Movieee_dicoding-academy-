//
//  RemoteDataSource.swift
//  Movieee
//
//  Created by Sholi on 11/07/21.
//

import Foundation
import Alamofire
import RxSwift

protocol RemoteDataSourceProtocol: AnyObject {    
    func getMovies(type: MovieType.RawValue) -> Observable<[MovieResponse.Result]>
    func getDetailMovie(id: Int) -> Observable<DetailMovieResponse>
    
    func getTvs(type: TvType.RawValue) -> Observable<[TvResponse.Result]>
    func getDetailTv(id: Int) -> Observable<DetailTvResponse>
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource =  RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
   
    
    
    func getMovies(type: MovieType.RawValue) -> Observable<[MovieResponse.Result]>{
        return Observable<[MovieResponse.Result]>.create { observer in
            var endpoint = ""
            switch type {
            case MovieType.POPULAR.rawValue:
                endpoint = Endpoints.Gets.popularMovies.url
            case MovieType.TOP_RATED.rawValue:
                endpoint = Endpoints.Gets.topRatedMovies.url
            case MovieType.UPCOMING.rawValue:
                endpoint = Endpoints.Gets.upcomingMovies.url
            default:
                endpoint = Endpoints.Gets.nowPlayingMovies.url
            }
            
            if let url = URL(string: endpoint) {
                AF.request(url).validate().responseDecodable(of: MovieResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value.results)
                        observer.onCompleted()
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func getDetailMovie(id: Int) -> Observable<DetailMovieResponse> {
        return Observable<DetailMovieResponse>.create { observer in
            if let url = URL(string: Endpoints.Gets.detailMovie(id: id).url) {
                AF.request(url).validate().responseDecodable(of: DetailMovieResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func getTvs(type: TvType.RawValue) -> Observable<[TvResponse.Result]> {
        return Observable<[TvResponse.Result]>.create { observer in
            var endpoint = ""
            switch type {
            case TvType.POPULAR.rawValue:
                endpoint = Endpoints.Gets.popularTv.url
            case TvType.TOP_RATED.rawValue:
                endpoint = Endpoints.Gets.topRatedTv.url
            case TvType.ON_THE_AIR.rawValue:
                endpoint = Endpoints.Gets.onTheAirTv.url
            case TvType.AIRING_TODAY.rawValue:
                endpoint = Endpoints.Gets.airingTodayTv.url
            default:
                endpoint = Endpoints.Gets.popularTv.url
            }
            
            if let url = URL(string: endpoint) {
                AF.request(url).validate().responseDecodable(of: TvResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value.results)
                        observer.onCompleted()
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func getDetailTv(id: Int) -> Observable<DetailTvResponse> {
        return Observable<DetailTvResponse>.create { observer in
            if let url = URL(string: Endpoints.Gets.detailTv(id: id).url) {
                
                AF.request(url).validate().responseDecodable(of: DetailTvResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure:
                        observer.onError(URLError.invalidResponse)
                    }
                }
            }
            return Disposables.create() 
        }
    }
    
}
