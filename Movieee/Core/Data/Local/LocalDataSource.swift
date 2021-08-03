//
//  LocalDataSource.swift
//  LocalDataSource
//
//  Created by Sholi on 01/08/21.
//

import Foundation
import RealmSwift

protocol LocalDataSourceProtocol: AnyObject {
    
    func getMovies(type: MovieType.RawValue, result: @escaping (Result<[MovieEntity], DatabaseError>) -> Void)
    func addMovies(
        movies: [MovieEntity],
        type: MovieType.RawValue,
        result: @escaping (Result<Bool, DatabaseError>) -> Void
    )
    
    func getDetailMovie(id: Int, result: @escaping (Result<[DetailMovieEntity], DatabaseError>) -> Void)
    func addDetailMovie(
        movie: DetailMovieEntity,
        result: @escaping (Result<Bool, DatabaseError>) -> Void
    )
    
    func getTvs(type: TvType.RawValue, result: @escaping (Result<[TvEntity], DatabaseError>) -> Void)
    func addTvs(
        tvs: [TvEntity],
        type: MovieType.RawValue,
        result: @escaping (Result<Bool, DatabaseError>) -> Void
    )
    
    func getDetailTv(id: Int, result: @escaping (Result<[DetailTvEntity], DatabaseError>) -> Void)
    func addDetailTv(
        tv: DetailTvEntity,
        result: @escaping (Result<Bool, DatabaseError>) -> Void
    )
}

final class LocalDataSource: NSObject {
    
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    static let sharedInstance: (Realm?) -> LocalDataSource = {
        realmDatabase in return LocalDataSource(realm: realmDatabase)
    }
    
}

extension LocalDataSource: LocalDataSourceProtocol {
   
    
    
    func getMovies(
        type: MovieType.RawValue,
        result: @escaping (Result<[MovieEntity], DatabaseError>) -> Void
    ) {
        if let realm = realm {
            let categories: Results<MovieEntity> = {
                realm.objects(MovieEntity.self)
                    .sorted(byKeyPath: "id", ascending: true)
                    .filter("type = '\(type)'")
            }()
            result(.success(categories.toArray(ofType: MovieEntity.self)))
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
    func addMovies(
        movies: [MovieEntity],
        type: MovieType.RawValue,
        result: @escaping (Result<Bool, DatabaseError>) -> Void
    ) {
        if let realm = realm {
            do {
                try realm.write {
                    for movie in movies {
                        movie.setup(type: type)
                        realm.add(movie, update: .all)
                    }
                    result(.success(true))
                }
            } catch {
                result(.failure(.requestFailed))
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }
    func getDetailMovie(id: Int, result: @escaping (Result<[DetailMovieEntity], DatabaseError>) -> Void) {
        if let realm = realm {
            let categories: Results<DetailMovieEntity> = {
                realm.objects(DetailMovieEntity.self)
                    .filter("movieId = \(id)")
            }()
            result(.success(categories.toArray(ofType: DetailMovieEntity.self)))
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
    func addDetailMovie(movie: DetailMovieEntity, result: @escaping (Result<Bool, DatabaseError>) -> Void) {
        if let realm = realm {
            do {
                try realm.write {
                    realm.add(movie, update: .all)
                    result(.success(true))
                }
            } catch {
                result(.failure(.requestFailed))
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
    func getTvs(type: TvType.RawValue, result: @escaping (Result<[TvEntity], DatabaseError>) -> Void) {
        if let realm = realm {
            let categories: Results<TvEntity> = {
                realm.objects(TvEntity.self)
                    .sorted(byKeyPath: "id", ascending: true)
                    .filter("type = '\(type)'")
            }()
            result(.success(categories.toArray(ofType: TvEntity.self)))
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
    func addTvs(tvs: [TvEntity], type: MovieType.RawValue, result: @escaping (Result<Bool, DatabaseError>) -> Void) {
        if let realm = realm {
            do {
                try realm.write {
                    for tv in tvs {
                        tv.setup(type: type)
                        realm.add(tv, update: .all)
                    }
                    result(.success(true))
                }
            } catch {
                result(.failure(.requestFailed))
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
    func getDetailTv(id: Int, result: @escaping (Result<[DetailTvEntity], DatabaseError>) -> Void) {
        if let realm = realm {
            let categories: Results<DetailTvEntity> = {
                realm.objects(DetailTvEntity.self)
                    .filter("tvId = \(id)")
            }()
            result(.success(categories.toArray(ofType: DetailTvEntity.self)))
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
    func addDetailTv(tv: DetailTvEntity, result: @escaping (Result<Bool, DatabaseError>) -> Void) {
        if let realm = realm {
            do {
                try realm.write {
                    realm.add(tv, update: .all)
                    result(.success(true))
                }
            } catch {
                result(.failure(.requestFailed))
            }
        } else {
            result(.failure(.invalidInstance))
        }
    }
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
