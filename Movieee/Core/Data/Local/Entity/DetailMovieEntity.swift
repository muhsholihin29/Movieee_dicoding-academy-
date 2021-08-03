//
//  DetailMovieEntity.swift
//  DetailMovieEntity
//
//  Created by Sholi on 03/08/21.
//

import Foundation
import RealmSwift

class DetailMovieEntity: Object{
    
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var budget: Int = 0
    var genres = List<Genre>()
    @objc dynamic var homepage: String = ""
    @objc dynamic var movieId: Int = 0
    @objc dynamic var imdbID: String = ""
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var popularity: Double = 0
    @objc dynamic var posterPath: String = ""
    var productionCompanies = List<ProductionCompany>()
    var productionCountries = List<ProductionCountry>()
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var revenue: Int = 0
    @objc dynamic var runtime: Int = 0
    var spokenLanguages = List<SpokenLanguage>()
    @objc dynamic var status: String = ""
    @objc dynamic var tagline: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var video: Bool = false
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var voteCount: Int = 0
    
    override static func primaryKey() -> String? {
        return "movieId"
    }
}
