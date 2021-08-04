//
//  LocalDataSource.swift
//  LocalDataSource
//
//  Created by Sholi on 01/08/21.
//

import Foundation
import RealmSwift
import Combine

protocol LocalDataSourceProtocol: AnyObject {
    
    func getMovies(type: MovieType.RawValue) -> AnyPublisher<[MovieEntity], Error>
    func addMovies(movies: [MovieEntity], type: MovieType.RawValue) -> AnyPublisher<Bool, Error>
    
    func getDetailMovie(id: Int) -> AnyPublisher<[DetailMovieEntity], Error>
    func addDetailMovie(movie: DetailMovieEntity) -> AnyPublisher<Bool, Error>
    
    func getTvs(type: TvType.RawValue) -> AnyPublisher<[TvEntity], Error>
    func addTvs(tvs: [TvEntity], type: MovieType.RawValue) -> AnyPublisher<Bool, Error>
    
    func getDetailTv(id: Int) -> AnyPublisher<[DetailTvEntity], Error>
    func addDetailTv(tv: DetailTvEntity) -> AnyPublisher<Bool, Error>
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
    
    func getMovies(type: MovieType.RawValue) -> AnyPublisher<[MovieEntity], Error> {
        return Future<[MovieEntity], Error> { completion in
            if let realm = self.realm {
                let categories: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .sorted(byKeyPath: "id", ascending: true)
                        .filter("type = '\(type)'")
                }()
                completion(.success(categories.toArray(ofType: MovieEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addMovies(movies: [MovieEntity], type: MovieType.RawValue) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for movie in movies {
                            movie.setup(type: type)
                            realm.add(movie, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getDetailMovie(id: Int) -> AnyPublisher<[DetailMovieEntity], Error> {
        return Future<[DetailMovieEntity], Error> { completion in
            if let realm = self.realm {
                let categories: Results<DetailMovieEntity> = {
                    realm.objects(DetailMovieEntity.self)
                        .filter("movieId = \(id)")
                }()
                completion(.success(categories.toArray(ofType: DetailMovieEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addDetailMovie(movie: DetailMovieEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(movie, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getTvs(type: TvType.RawValue) -> AnyPublisher<[TvEntity], Error> {
        return Future<[TvEntity], Error> { completion in
            if let realm = self.realm {
                let categories: Results<TvEntity> = {
                    realm.objects(TvEntity.self)
                        .sorted(byKeyPath: "id", ascending: true)
                        .filter("type = '\(type)'")
                }()
                completion(.success(categories.toArray(ofType: TvEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addTvs(tvs: [TvEntity], type: MovieType.RawValue) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for tv in tvs {
                            tv.setup(type: type)
                            realm.add(tv, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getDetailTv(id: Int) -> AnyPublisher<[DetailTvEntity], Error> {
        return Future<[DetailTvEntity], Error> { completion in
            if let realm = self.realm {
                let categories: Results<DetailTvEntity> = {
                    realm.objects(DetailTvEntity.self)
                        .filter("tvId = \(id)")
                }()
                completion(.success(categories.toArray(ofType: DetailTvEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addDetailTv(tv: DetailTvEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(tv, update: .all)
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
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
