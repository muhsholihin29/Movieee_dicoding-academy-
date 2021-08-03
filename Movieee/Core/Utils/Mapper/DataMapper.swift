//
//  DataMapper.swift
//  Movieee
//
//  Created by Sholi on 26/07/21.
//

import Foundation
import RealmSwift

final class DataMapper {
    
    static func mapMovieResponseToDomain(
        input movieResultResponse: [MovieResponse.Result]
    ) -> [Movie] {
        return movieResultResponse.map { result in
            return Movie(
                adult: result.adult ?? false,
                backdropPath: result.backdropPath ?? "",
                genreIDS: result.genreIDS ?? [Int](),
                id: result.id,
                originalLanguage: result.originalLanguage ?? "",
                originalTitle: result.originalTitle ?? "",
                overview: result.overview ?? "",
                popularity: result.popularity ?? 0,
                posterPath: result.posterPath ?? "",
                releaseDate: result.releaseDate ?? "",
                title: result.title ?? "",
                video: result.video ?? false,
                voteAverage: result.voteAverage ?? 0,
                voteCount: result.voteCount ?? 0
            )
        }
    }
    
    static func mapTvResponseToDomain(
        input tvResultResponses: [TvResponse.Result]
    ) -> [Tv] {
        
        return tvResultResponses.map { result in
            return Tv(
                backdropPath: result.backdropPath ?? "",
                firstAirDate: result.firstAirDate ?? "",
                genreIDS: result.genreIDS ?? [Int](),
                id: result.id,
                name: result.name ?? "",
                originCountry:result.originCountry ?? [String](),
                originalLanguage: result.originalLanguage ?? "",
                originalName: result.originalName ?? "",
                overview: result.overview ?? "",
                popularity: result.popularity ?? 0,
                posterPath: result.posterPath ?? "",
                voteAverage: result.voteAverage ?? 0,
                voteCount: result.voteCount ?? 0
            )
        }
    }
    
    static func mapDetailMovieResponseToDomain(
        input detail: DetailMovieResponse
    ) -> DetailMovie {
        return DetailMovie(
            adult: detail.adult ?? false,
            backdropPath: detail.backdropPath ?? "",
            budget: detail.budget ?? 0,
            genres: detail.genres?.map { genre in
                return DetailMovie.Genre(
                    id: genre.id,
                    name: genre.name
                )
            } ?? [],
            homepage: detail.homepage ?? "",
            id: detail.id,
            imdbID: detail.imdbID ?? "",
            originalLanguage: detail.originalLanguage ?? "",
            originalTitle: detail.originalTitle ?? "",
            overview: detail.overview ?? "",
            popularity: detail.popularity ?? 0,
            posterPath: detail.posterPath ?? "",
            productionCompanies: detail.productionCompanies?.map { company in
                return DetailMovie.ProductionCompany(
                    id: company.id,
                    logoPath: company.logoPath,
                    name: company.name,
                    originCountry: company.originCountry
                )
            } ?? [],
            productionCountries: detail.productionCountries?.map { country in
                return DetailMovie.ProductionCountry(
                    iso3166_1: country.iso3166_1,
                    name: country.name
                )
            } ?? [],
            releaseDate: detail.releaseDate ?? "",
            revenue: detail.revenue ?? 0,
            runtime: detail.runtime ?? 0,
            spokenLanguages: detail.spokenLanguages?.map { language in
                return DetailMovie.SpokenLanguage(
                    englishName: language.englishName,
                    iso639_1: language.iso639_1,
                    name: language.name
                )
            } ?? [],
            status: detail.status ?? "",
            tagline: detail.tagline ?? "",
            title: detail.title ?? "",
            video: detail.video ?? false,
            voteAverage: detail.voteAverage ?? 0,
            voteCount: detail.voteCount ?? 0
        )
    }
    
    static func mapDetailTvResponseToDomain(
        input detail: DetailTvResponse
    ) -> DetailTv {
        return DetailTv(
            backdropPath: detail.backdropPath ?? "",
            createdBy: detail.createdBy?.map { created in
                DetailTv.CreatedBy(
                    id: created.id,
                    creditID: created.creditID,
                    name: created.name,
                    gender: created.gender,
                    profilePath: created.profilePath
                )
            } ?? [],
            episodeRunTime: detail.episodeRunTime ?? [],
            firstAirDate: detail.firstAirDate ?? "",
            genres: detail.genres?.map { genre in
                DetailTv.Genre(id: genre.id, name: genre.name)
            } ?? [],
            homepage: detail.homepage ?? "",
            id: detail.id,
            inProduction: detail.inProduction ?? false,
            languages: detail.languages ?? [],
            lastAirDate: detail.lastAirDate ?? "",
            lastEpisodeToAir: DetailTv.EpisodeToAir(
                airDate: detail.lastEpisodeToAir?.airDate,
                episodeNumber: detail.lastEpisodeToAir?.episodeNumber,
                id: detail.lastEpisodeToAir?.id,
                name: detail.lastEpisodeToAir?.name,
                overview: detail.lastEpisodeToAir?.overview,
                productionCode: detail.lastEpisodeToAir?.productionCode,
                seasonNumber: detail.lastEpisodeToAir?.seasonNumber,
                stillPath: detail.lastEpisodeToAir?.stillPath,
                voteAverage: detail.lastEpisodeToAir?.voteAverage,
                voteCount: detail.lastEpisodeToAir?.voteCount
            ),
            name: detail.name ?? "",
            nextEpisodeToAir: DetailTv.EpisodeToAir(
                airDate: detail.nextEpisodeToAir?.airDate,
                episodeNumber: detail.nextEpisodeToAir?.episodeNumber,
                id: detail.nextEpisodeToAir?.id,
                name: detail.nextEpisodeToAir?.name,
                overview: detail.nextEpisodeToAir?.overview,
                productionCode: detail.nextEpisodeToAir?.productionCode,
                seasonNumber: detail.nextEpisodeToAir?.seasonNumber,
                stillPath: detail.nextEpisodeToAir?.stillPath,
                voteAverage: detail.nextEpisodeToAir?.voteAverage,
                voteCount: detail.nextEpisodeToAir?.voteCount
            ),
            networks: detail.networks?.map { network in
                DetailTv.Network(name: network.name, id: network.id, logoPath: network.logoPath, originCountry: network.originCountry)
            } ?? [],
            numberOfEpisodes: detail.numberOfEpisodes ?? 0,
            numberOfSeasons: detail.numberOfSeasons ?? 0,
            originCountry: detail.originCountry ?? [],
            originalLanguage: detail.originalLanguage ?? "",
            originalName: detail.originalName ?? "",
            overview: detail.overview ?? "",
            popularity: detail.popularity ?? 0,
            posterPath: detail.posterPath ?? "",
            productionCompanies: detail.productionCompanies?.map { company in
                DetailTv.ProductionCompany(name: company.name, id: company.id, logoPath: company.logoPath, originCountry: company.originCountry)
            } ?? [],
            productionCountries: detail.productionCountries?.map { country in
                DetailTv.ProductionCountry(iso3166_1: country.iso3166_1, name: country.name)
            } ?? [],
            seasons: detail.seasons?.map { season in
                return DetailTv.Season(
                    airDate: season.airDate,
                    episodeCount: season.episodeCount,
                    id: season.id,
                    name: season.name,
                    overview: season.overview,
                    posterPath: season.posterPath,
                    seasonNumber: season.seasonNumber
                )
            } ?? [],
            spokenLanguages: detail.spokenLanguages?.map { language in
                DetailTv.SpokenLanguage(englishName: language.englishName, iso639_1: language.iso639_1, name: language.name)
            } ?? [],
            status: detail.status ?? "",
            tagline: detail.tagline ?? "",
            type: detail.type ?? "",
            voteAverage: detail.voteAverage ?? 0,
            voteCount: detail.voteCount ?? 0
        )
    }
    
    static func mapMovieEntityToDomain(
        input movieResultResponse: [MovieEntity]
    ) -> [Movie] {
        return movieResultResponse.map { result in
            return Movie(
                adult: result.adult ,
                backdropPath: result.backdropPath ,
                genreIDS: Array(result.genreIDS),
                id: result.movieId,
                originalLanguage: result.originalLanguage,
                originalTitle: result.originalTitle,
                overview: result.overview,
                popularity: result.popularity,
                posterPath: result.posterPath,
                releaseDate: result.releaseDate,
                title: result.title,
                video: result.video,
                voteAverage: result.voteAverage,
                voteCount: result.voteCount
            )
        }
    }
    
    static func mapTvEntityToDomain(
        input tvResultResponses: [TvEntity]
    ) -> [Tv] {
        
        return tvResultResponses.map { result in
            return Tv(
                backdropPath: result.backdropPath,
                firstAirDate: result.firstAirDate,
                genreIDS: Array(result.genreIDS),
                id: result.tvId,
                name: result.name,
                originCountry: Array(result.originCountry),
                originalLanguage: result.originalLanguage,
                originalName: result.originalName,
                overview: result.overview,
                popularity: result.popularity,
                posterPath: result.posterPath,
                voteAverage: result.voteAverage,
                voteCount: result.voteCount
            )
        }
    }
    
    static func mapMovieResponseToEntity(
        input movieResultResponse: [MovieResponse.Result]
    ) -> [MovieEntity] {
        return movieResultResponse.map { result in
            let entity = MovieEntity()
            entity.adult = result.adult ?? false
            entity.backdropPath = result.backdropPath ?? ""
            entity.genreIDS.append(objectsIn: result.genreIDS ?? [])
            entity.movieId = result.id
            entity.originalLanguage = result.originalLanguage ?? ""
            entity.originalTitle = result.originalTitle ?? ""
            entity.overview = result.overview ?? ""
            entity.popularity = result.popularity ?? 0
            entity.posterPath = result.posterPath ?? ""
            entity.releaseDate = result.releaseDate ?? ""
            entity.title = result.title ?? ""
            entity.video = result.video ?? false
            entity.voteAverage = result.voteAverage ?? 0
            entity.voteCount = result.voteCount ?? 0
            return entity
        }
    }
    
    static func mapTvResponseToEntity(
        input tvResultResponses: [TvResponse.Result]
    ) -> [TvEntity] {
        
        return tvResultResponses.map { result in
            let entity = TvEntity()
            entity.backdropPath = result.backdropPath ?? ""
            entity.firstAirDate = result.firstAirDate ?? ""
            entity.genreIDS.append(objectsIn: result.genreIDS ?? [])
            entity.tvId = result.id
            entity.name = result.name ?? ""
            entity.originCountry.append(objectsIn: result.originCountry ?? [])
            entity.originalLanguage = result.originalLanguage ?? ""
            entity.originalName = result.originalName ?? ""
            entity.overview = result.overview ?? ""
            entity.popularity = result.popularity ?? 0
            entity.posterPath = result.posterPath ?? ""
            entity.voteAverage = result.voteAverage ?? 0
            entity.voteCount = result.voteCount ?? 0
            return entity
        }
    }
    
    static func mapDetailMovieResponseToEntity(
        input detail: DetailMovieResponse
    ) -> DetailMovieEntity {
        let entity = DetailMovieEntity()
        entity.adult = detail.adult ?? false
        entity.backdropPath = detail.backdropPath ?? ""
        entity.budget = detail.budget ?? 0
        entity.genres.append(objectsIn: detail.genres?.map { genre in
            let i = Genre()
            i.id = genre.id
            i.name = genre.name ?? ""
            return i
        } ?? [])
        entity.homepage = detail.homepage ?? ""
        entity.movieId = detail.id
        entity.imdbID = detail.imdbID ?? ""
        entity.originalLanguage = detail.originalLanguage ?? ""
        entity.originalTitle = detail.originalTitle ?? ""
        entity.overview = detail.overview ?? ""
        entity.popularity = detail.popularity ?? 0
        entity.posterPath = detail.posterPath ?? ""
        entity.productionCompanies.append(objectsIn: detail.productionCompanies?.map { company in
            let i = ProductionCompany()
            i.id = company.id
            i.logoPath = company.logoPath ?? ""
            i.name = company.name ?? ""
            i.originCountry = company.originCountry ?? ""
            return i
        } ?? [])
        entity.productionCountries.append(objectsIn: detail.productionCountries?.map { country in
            let i = ProductionCountry()
            i.iso3166_1 = country.iso3166_1 ?? ""
            i.name = country.name ?? ""
            return i
        } ?? [])
        entity.releaseDate = detail.releaseDate ?? ""
        entity.revenue = detail.revenue ?? 0
        entity.runtime = detail.runtime ?? 0
        entity.spokenLanguages.append(objectsIn: detail.spokenLanguages?.map { language in
            let i = SpokenLanguage()
            i.englishName = language.englishName ?? ""
            i.iso639_1 = language.iso639_1 ?? ""
            i.name = language.name ?? ""
            return i
        } ?? [])
        entity.status = detail.status ?? ""
        entity.tagline = detail.tagline ?? ""
        entity.title = detail.title ?? ""
        entity.video = detail.video ?? false
        entity.voteAverage = detail.voteAverage ?? 0
        entity.voteCount = detail.voteCount ?? 0
        return entity
    }
    
    static func mapDetailTvResponseToEntity(
        input detail: DetailTvResponse
    ) -> DetailTvEntity {
        let entity = DetailTvEntity()
        entity.backdropPath = detail.backdropPath ?? ""
        entity.createdBy.append(objectsIn: detail.createdBy?.map { created in
            let i = CreatedBy()
            i.id = created.id ?? 0
            i.creditID = created.creditID ?? ""
            i.name = created.name ?? ""
            i.gender = created.gender ?? 0
            i.profilePath = created.profilePath ?? ""
            return i
        } ?? [])
        entity.episodeRunTime.append(objectsIn: detail.episodeRunTime ?? [])
        entity.firstAirDate = detail.firstAirDate ?? ""
        entity.genres.append(objectsIn: detail.genres?.map { genre in
            let i = Genre()
            i.id = genre.id ?? 0
            i.name = genre.name ?? ""
            return i
        } ?? [])
        entity.homepage = detail.homepage ?? ""
        entity.tvId = detail.id
        entity.inProduction = detail.inProduction ?? false
        entity.languages.append(objectsIn: detail.languages ?? [])
        entity.lastAirDate = detail.lastAirDate ?? ""
        entity.lastEpisodeToAir?.airDate = detail.lastEpisodeToAir?.airDate ?? ""
        entity.lastEpisodeToAir?.episodeNumber = detail.lastEpisodeToAir?.episodeNumber ?? 0
        entity.lastEpisodeToAir?.id = detail.lastEpisodeToAir?.id ?? 0
        entity.lastEpisodeToAir?.name = detail.lastEpisodeToAir?.name ?? ""
        entity.lastEpisodeToAir?.overview = detail.lastEpisodeToAir?.overview ?? ""
        entity.lastEpisodeToAir?.productionCode = detail.lastEpisodeToAir?.productionCode ?? ""
        entity.lastEpisodeToAir?.seasonNumber = detail.lastEpisodeToAir?.seasonNumber ?? 0
        entity.lastEpisodeToAir?.stillPath = detail.lastEpisodeToAir?.stillPath ?? ""
        entity.lastEpisodeToAir?.voteAverage = detail.lastEpisodeToAir?.voteAverage ?? 0
        entity.lastEpisodeToAir?.voteCount = detail.lastEpisodeToAir?.voteCount ?? 0
        entity.name = detail.name ?? ""
        entity.nextEpisodeToAir?.airDate = detail.nextEpisodeToAir?.airDate ?? ""
        entity.nextEpisodeToAir?.episodeNumber = detail.nextEpisodeToAir?.episodeNumber ?? 0
        entity.nextEpisodeToAir?.id = detail.nextEpisodeToAir?.id ?? 0
        entity.nextEpisodeToAir?.name = detail.nextEpisodeToAir?.name ?? ""
        entity.nextEpisodeToAir?.overview = detail.nextEpisodeToAir?.overview ?? ""
        entity.nextEpisodeToAir?.productionCode = detail.nextEpisodeToAir?.productionCode ?? ""
        entity.nextEpisodeToAir?.seasonNumber = detail.nextEpisodeToAir?.seasonNumber ?? 0
        entity.nextEpisodeToAir?.stillPath = detail.nextEpisodeToAir?.stillPath ?? ""
        entity.nextEpisodeToAir?.voteAverage = detail.nextEpisodeToAir?.voteAverage ?? 0
        entity.nextEpisodeToAir?.voteCount = detail.nextEpisodeToAir?.voteCount ?? 0
        
        entity.networks.append(objectsIn: detail.networks?.map { network in
            let i = Network()
            i.name = network.name ?? ""
            i.id = network.id ?? 0
            i.logoPath = network.logoPath ?? ""
            i.originCountry = network.originCountry ?? ""
            return i
        } ?? [])
        entity.numberOfEpisodes = detail.numberOfEpisodes ?? 0
        entity.numberOfSeasons = detail.numberOfSeasons ?? 0
        entity.originCountry.append(objectsIn: detail.originCountry ?? [])
        entity.originalLanguage = detail.originalLanguage ?? ""
        entity.originalName = detail.originalName ?? ""
        entity.overview = detail.overview ?? ""
        entity.popularity = detail.popularity ?? 0
        entity.posterPath = detail.posterPath ?? ""
        entity.productionCompanies.append(objectsIn: detail.productionCompanies?.map { company in
            let i = ProductionCompany()
            i.name = company.name ?? ""
            i.id = company.id ?? 0
            i.logoPath = company.logoPath ?? ""
            i.originCountry = company.originCountry ?? ""
            return i
        } ?? [])
        entity.productionCountries.append(objectsIn: detail.productionCountries?.map { country in
            let i = ProductionCountry()
            i.iso3166_1 = country.iso3166_1 ?? ""
            i.name = country.name ?? ""
            return i
        } ?? [])
        entity.seasons.append(objectsIn: detail.seasons?.map { season in
            let i = Season()
            i.airDate = season.airDate ?? ""
            i.episodeCount = season.episodeCount ?? 0
            i.id = season.id ?? 0
            i.name = season.name ?? ""
            i.overview = season.overview ?? ""
            i.posterPath = season.posterPath ?? ""
            i.seasonNumber = season.seasonNumber ?? 0
            return i
        } ?? [])
        entity.spokenLanguages.append(objectsIn: detail.spokenLanguages?.map { language in
            let i = SpokenLanguage()
            i.englishName = language.englishName ?? ""
            i.iso639_1 = language.iso639_1 ?? ""
            i.name = language.name ?? ""
            return i
        } ?? [])
        entity.status = detail.status ?? ""
        entity.tagline = detail.tagline ?? ""
        entity.type = detail.type ?? ""
        entity.voteAverage = detail.voteAverage ?? 0
        entity.voteCount = detail.voteCount ?? 0
        return entity
    }
    
    static func mapDetailMovieEntityToDomain(
        input detail: DetailMovieEntity
    ) -> DetailMovie {
        return DetailMovie(
            adult: detail.adult ,
            backdropPath: detail.backdropPath ,
            budget: detail.budget,
            genres: Array(detail.genres.map { genre in
                DetailMovie.Genre(
                    id: genre.id,
                    name: genre.name
                )
            }),
            homepage: detail.homepage,
            id: detail.movieId,
            imdbID: detail.imdbID,
            originalLanguage: detail.originalLanguage,
            originalTitle: detail.originalTitle,
            overview: detail.overview,
            popularity: detail.popularity,
            posterPath: detail.posterPath,
            productionCompanies: Array(detail.productionCompanies.map { company in
                DetailMovie.ProductionCompany(
                    id: company.id,
                    logoPath: company.logoPath,
                    name: company.name,
                    originCountry: company.originCountry
                )
            }),
            productionCountries: Array(detail.productionCountries.map { country in
                DetailMovie.ProductionCountry(
                    iso3166_1: country.iso3166_1,
                    name: country.name
                )
            }),
            releaseDate: detail.releaseDate,
            revenue: detail.revenue,
            runtime: detail.runtime,
            spokenLanguages: Array(detail.spokenLanguages.map { language in
                DetailMovie.SpokenLanguage(
                    englishName: language.englishName,
                    iso639_1: language.iso639_1,
                    name: language.name
                )
            }),
            status: detail.status,
            tagline: detail.tagline,
            title: detail.title,
            video: detail.video,
            voteAverage: detail.voteAverage,
            voteCount: detail.voteCount
        )
    }
    
    static func mapDetailTvEntityToDomain(
        input detail: DetailTvEntity
    ) -> DetailTv {
        return DetailTv(
            backdropPath: detail.backdropPath,
            createdBy: Array(detail.createdBy.map { created in
                DetailTv.CreatedBy(
                    id: created.id,
                    creditID: created.creditID,
                    name: created.name,
                    gender: created.gender,
                    profilePath: created.profilePath
                )
            }),
            episodeRunTime: Array(detail.episodeRunTime),
            firstAirDate: detail.firstAirDate,
            genres: Array(detail.genres.map { genre in
                DetailTv.Genre(id: genre.id, name: genre.name)
            }),
            homepage: detail.homepage,
            id: detail.tvId,
            inProduction: detail.inProduction,
            languages: Array(detail.languages),
            lastAirDate: detail.lastAirDate,
            lastEpisodeToAir: DetailTv.EpisodeToAir(
                airDate: detail.lastEpisodeToAir?.airDate,
                episodeNumber: detail.lastEpisodeToAir?.episodeNumber,
                id: detail.lastEpisodeToAir?.id,
                name: detail.lastEpisodeToAir?.name,
                overview: detail.lastEpisodeToAir?.overview,
                productionCode: detail.lastEpisodeToAir?.productionCode,
                seasonNumber: detail.lastEpisodeToAir?.seasonNumber,
                stillPath: detail.lastEpisodeToAir?.stillPath,
                voteAverage: detail.lastEpisodeToAir?.voteAverage,
                voteCount: detail.lastEpisodeToAir?.voteCount
            ),
            name: detail.name,
            nextEpisodeToAir: DetailTv.EpisodeToAir(
                airDate: detail.nextEpisodeToAir?.airDate,
                episodeNumber: detail.nextEpisodeToAir?.episodeNumber,
                id: detail.nextEpisodeToAir?.id,
                name: detail.nextEpisodeToAir?.name,
                overview: detail.nextEpisodeToAir?.overview,
                productionCode: detail.nextEpisodeToAir?.productionCode,
                seasonNumber: detail.nextEpisodeToAir?.seasonNumber,
                stillPath: detail.nextEpisodeToAir?.stillPath,
                voteAverage: detail.nextEpisodeToAir?.voteAverage,
                voteCount: detail.nextEpisodeToAir?.voteCount
            ),
            networks: Array(detail.networks.map { network in
                DetailTv.Network(name: network.name, id: network.id, logoPath: network.logoPath, originCountry: network.originCountry)
            }),
            numberOfEpisodes: detail.numberOfEpisodes,
            numberOfSeasons: detail.numberOfSeasons,
            originCountry: Array(detail.originCountry),
            originalLanguage: detail.originalLanguage,
            originalName: detail.originalName,
            overview: detail.overview,
            popularity: detail.popularity,
            posterPath: detail.posterPath,
            productionCompanies: Array(detail.productionCompanies.map { company in
                DetailTv.ProductionCompany(name: company.name, id: company.id, logoPath: company.logoPath, originCountry: company.originCountry)
            }),
            productionCountries: Array(detail.productionCountries.map { country in
                DetailTv.ProductionCountry(iso3166_1: country.iso3166_1, name: country.name)
            }),
            seasons: Array(detail.seasons.map { season in
                DetailTv.Season(
                    airDate: season.airDate,
                    episodeCount: season.episodeCount,
                    id: season.id,
                    name: season.name,
                    overview: season.overview,
                    posterPath: season.posterPath,
                    seasonNumber: season.seasonNumber
                )
            }),
            spokenLanguages: Array(detail.spokenLanguages.map { language in
                DetailTv.SpokenLanguage(englishName: language.englishName, iso639_1: language.iso639_1, name: language.name)
            }),
            status: detail.status,
            tagline: detail.tagline,
            type: detail.type,
            voteAverage: detail.voteAverage,
            voteCount: detail.voteCount
        )
    }
}
