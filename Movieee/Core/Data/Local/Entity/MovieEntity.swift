//
//  MovieEntity.swift
//  MovieEntity
//
//  Created by Sholi on 01/08/21.
//

import Foundation
import RealmSwift

class MovieEntity: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String = ""
    var genreIDS = List<Int>()
    @objc dynamic var movieId: Int = 0
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var popularity: Double = 0
    @objc dynamic var posterPath: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var video: Bool = false
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var type: String = ""
    @objc dynamic var compoundKey: String = ""
    
    override static func primaryKey() -> String? {
        return "compoundKey"
    }
    
    func setup(type: String){
        self.id = self.incrementID()
        self.type = type
        self.compoundKey = "\(self.movieId)\(self.type)"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(MovieEntity.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
