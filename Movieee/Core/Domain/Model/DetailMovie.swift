
import Foundation

// MARK: - DetailMovie
struct DetailMovie: Equatable, Identifiable {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    // MARK: - Genre
    struct Genre: Equatable {
        let id: Int
        let name: String?
    }
    
    // MARK: - ProductionCompany
    struct ProductionCompany: Equatable {
        let id: Int
        let logoPath, name, originCountry: String?
    }
    
    // MARK: - ProductionCountry
    struct ProductionCountry: Equatable {
        let iso3166_1, name: String?
    }
    
    // MARK: - SpokenLanguage
    struct SpokenLanguage: Equatable {
        let englishName, iso639_1, name: String?
    }
}
