//
//  DetailTvEntity.swift
//  DetailTvEntity
//
//  Created by Sholi on 03/08/21.
//

import Foundation
import RealmSwift

class DetailTvEntity: Object{
    @objc dynamic var backdropPath: String = ""
    var createdBy = List<CreatedBy>()
    var episodeRunTime = List<Int>()
    @objc dynamic var firstAirDate: String = ""
    var genres = List<Genre>()
    @objc dynamic var homepage: String = ""
    @objc dynamic var tvId: Int = 0
    @objc dynamic var inProduction: Bool = false
    var languages = List<String>()
    @objc dynamic var lastAirDate: String = ""
    @objc dynamic var lastEpisodeToAir: EpisodeToAir? = EpisodeToAir()
    @objc dynamic var name: String = ""
    @objc dynamic var nextEpisodeToAir: EpisodeToAir? = EpisodeToAir()
    var networks = List<Network>()
    @objc dynamic var numberOfEpisodes: Int = 0
    @objc dynamic var numberOfSeasons: Int = 0
    var originCountry = List<String>()
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var originalName: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var popularity: Double = 0
    @objc dynamic var posterPath: String = ""
    var productionCompanies = List<ProductionCompany>()
    var productionCountries = List<ProductionCountry>()
    var seasons = List<Season>()
    var spokenLanguages = List<SpokenLanguage>()
    @objc dynamic var status: String = ""
    @objc dynamic var tagline: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var voteCount: Int = 0
    
    override static func primaryKey() -> String? {
        return "tvId"
    }
}

class CreatedBy: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var creditID: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var gender: Int = 0
    @objc dynamic var profilePath: String = ""
}

class Genre: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}

class EpisodeToAir: Object {
    @objc dynamic var airDate: String = ""
    @objc dynamic var episodeNumber: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var productionCode: String = ""
    @objc dynamic var seasonNumber: Int = 0
    @objc dynamic var stillPath: String = ""
    @objc dynamic var voteAverage: Double = 0
    @objc dynamic var voteCount: Double = 0
}

class Network: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var logoPath: String = ""
    @objc dynamic var originCountry: String = ""
}

class ProductionCompany: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var logoPath: String = ""
    @objc dynamic var originCountry: String = ""
}

class ProductionCountry: Object {
    @objc dynamic var iso3166_1: String = ""
    @objc dynamic var name: String = ""
}

class Season: Object {
    @objc dynamic var airDate: String = ""
    @objc dynamic var episodeCount: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var seasonNumber: Int = 0
}

class SpokenLanguage: Object {
    @objc dynamic var englishName: String = ""
    @objc dynamic var iso639_1: String = ""
    @objc dynamic var name: String = ""
}
