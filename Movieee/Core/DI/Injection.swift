//
//  Injection.swift
//  Movieee
//
//  Created by Sholi on 27/07/21.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideRepository() -> MovieTvRepositoryProtocol {
        
        let realm = try? Realm()
        let local: LocalDataSource = LocalDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        
        return MovieTvRepository.sharedInstance(local, remote)
    }
    
    func provideMovie() -> MovieUseCase {
        let repository = provideRepository()
        return MovieInteractor(repository: repository)
    }
    
    func provideTv() -> TvUseCase {
        let repository = provideRepository()
        return TvInteractor(repository: repository)
    }
    
    func provideDetail() -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository)
    }
    
}
