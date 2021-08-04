//
//  LocalDataSource.swift
//  LocalDataSource
//
//  Created by Sholi on 01/08/21.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocalDataSourceProtocol: AnyObject {
    
    func getMovies(type: MovieType.RawValue) -> Observable<[MovieEntity]>
    func addMovies(movies: [MovieEntity], type: MovieType.RawValue) -> Observable<Bool>
    
    func getDetailMovie(id: Int) -> Observable<[DetailMovieEntity]>
    func addDetailMovie(movie: DetailMovieEntity) -> Observable<Bool>
    
    func getTvs(type: TvType.RawValue) -> Observable<[TvEntity]>
    func addTvs(tvs: [TvEntity],type: MovieType.RawValue) -> Observable<Bool>
    
    func getDetailTv(id: Int) -> Observable<[DetailTvEntity]>
    func addDetailTv(tv: DetailTvEntity) -> Observable<Bool>
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
    
    func getMovies(type: MovieType.RawValue) -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create { observer in
            if let realm = self.realm {
                let categories: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .sorted(byKeyPath: "id", ascending: true)
                        .filter("type = '\(type)'")
                }()
                observer.onNext(categories.toArray(ofType: MovieEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addMovies(movies: [MovieEntity], type: MovieType.RawValue) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for movie in movies {
                            movie.setup(type: type)
                            realm.add(movie, update: .all)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    func getDetailMovie(id: Int) -> Observable<[DetailMovieEntity]> {
        return Observable<[DetailMovieEntity]>.create { observer in
            if let realm = self.realm {
                let categories: Results<DetailMovieEntity> = {
                    realm.objects(DetailMovieEntity.self)
                        .filter("movieId = \(id)")
                }()
                observer.onNext(categories.toArray(ofType: DetailMovieEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addDetailMovie(movie: DetailMovieEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(movie, update: .all)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getTvs(type: TvType.RawValue) -> Observable<[TvEntity]> {
        return Observable<[TvEntity]>.create { observer in
            if let realm = self.realm {
                let categories: Results<TvEntity> = {
                    realm.objects(TvEntity.self)
                        .sorted(byKeyPath: "id", ascending: true)
                        .filter("type = '\(type)'")
                }()
                observer.onNext(categories.toArray(ofType: TvEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addTvs(tvs: [TvEntity], type: MovieType.RawValue) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for tv in tvs {
                            tv.setup(type: type)
                            realm.add(tv, update: .all)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getDetailTv(id: Int) -> Observable<[DetailTvEntity]> {
        return Observable<[DetailTvEntity]>.create { observer in
            if let realm = self.realm {
                let categories: Results<DetailTvEntity> = {
                    realm.objects(DetailTvEntity.self)
                        .filter("tvId = \(id)")
                }()
                observer.onNext(categories.toArray(ofType: DetailTvEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addDetailTv(tv: DetailTvEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(tv, update: .all)
                        observer.onNext(true)
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
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
