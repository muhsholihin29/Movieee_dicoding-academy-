//
//  TvEntity.swift
//  TvEntity
//
//  Created by Sholi on 02/08/21.
//

import Foundation
import RealmSwift

class TvEntity: Object{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var firstAirDate: String = ""
    var genreIDS = List<Int>()
    @objc dynamic var tvId: Int = 0
    @objc dynamic var name: String = ""
    var originCountry = List<String>()
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var originalName: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var popularity: Double = 0
    @objc dynamic var posterPath: String = ""
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
        self.compoundKey = "\(self.tvId)\(self.type)"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(TvEntity.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
