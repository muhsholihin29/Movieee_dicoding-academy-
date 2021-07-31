//
//  Movie.swift
//  Movieee
//
//  Created by Sholi on 26/07/21.
//

import Foundation

struct Movie: Equatable, Identifiable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}
