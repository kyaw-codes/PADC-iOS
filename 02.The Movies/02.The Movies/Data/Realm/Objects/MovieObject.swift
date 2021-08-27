//
//  MovieObject.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 18/08/2021.
//

import RealmSwift

// MARK: - MovieObject

class MovieObject: Object {
    
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var adult: Bool?
    @Persisted var backdropPath: String?
    @Persisted var genreIDS: String
    @Persisted var originalLanguage: String?
    @Persisted var originalTitle: String?
    @Persisted var overview: String?
    @Persisted var popularity: Double?
    @Persisted var posterPath: String?
    @Persisted var releaseDate: String?
    @Persisted var name: String?
    @Persisted var title: String?
    @Persisted var video: Bool?
    @Persisted var voteAverage: Double?
    @Persisted var voteCount: Int?
    @Persisted var mediaType: String?
    @Persisted var pageNo: Int?
    @Persisted(originProperty: "movies") var actors: LinkingObjects<ActorObject>
    @Persisted var trailer: MovieTrailerEmbeddedObject?
    @Persisted var detail: MovieDetailEmbeddedObject?
    @Persisted var displayType: MovieDisplayType?
    @Persisted var similarMovies: List<MovieObject>
    
    func convertToMovie() -> Movie {
        Movie(
            adult: adult,
            backdropPath: backdropPath,
            genreIDS: genreIDS.split(separator: ",").map { Int($0) ?? -1 },
            id: id,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            releaseDate: releaseDate,
            name: name,
            title: title,
            video: video,
            voteAverage: voteAverage,
            voteCount: voteCount,
            mediaType: mediaType
        )
    }
}

// MARK: - MovieDetailEmbeddedObject

class MovieDetailEmbeddedObject: EmbeddedObject {
    
    @Persisted var adult: Bool?
    @Persisted var backdropPath: String?
    @Persisted var budget: Int?
    var genres: List<GenreObject> = List<GenreObject>()
    @Persisted var homepage: String?
    @Persisted var id: Int?
    @Persisted var imdbID: String?
    @Persisted var originalLanguage: String?
    @Persisted var originalTitle: String?
    @Persisted var originalName: String?
    @Persisted var name: String?
    @Persisted var overview: String?
    @Persisted var popularity: Double?
    @Persisted var posterPath: String?
    @Persisted var productionCompanies: List<ProductionCompanyEmbeddedObject>
    @Persisted var productionCountries: List<ProductionCountryEmbeddedObject>
    @Persisted var releaseDate: String?
    @Persisted var lastAirDate: String?
    @Persisted var revenue: Int?
    @Persisted var runtime: Int?
    @Persisted var spokenLanguages: List<SpokenLanguageEmbeddedObject>
    @Persisted var status: String?
    @Persisted var tagline: String?
    @Persisted var title: String?
    @Persisted var video: Bool?
    @Persisted var voteAverage: Double?
    @Persisted var voteCount: Int?
    @Persisted var episodeRunTime: List<Int>
    @Persisted var noOfSeasons: Int?
    @Persisted var mediaType: String?
    
    func convertToMovieDetail() -> MovieDetailResponse {
        MovieDetailResponse(
            adult: adult,
            backdropPath: backdropPath,
            budget: budget,
            genres: genres.map { $0.convertToGenre() },
            homepage: homepage,
            id: id,
            imdbID: imdbID,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            originalName: originalName,
            name: name,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            productionCompanies: productionCompanies.map { $0.convertToProductionCompany() },
            productionCountries: productionCountries.map { $0.convertToProductionCountry() },
            releaseDate: releaseDate,
            lastAirDate: lastAirDate,
            revenue: revenue,
            runtime: runtime,
            spokenLanguages: spokenLanguages.map { $0.convertToSpokenLanguage() },
            status: status,
            tagline: tagline,
            title: title,
            video: video,
            voteAverage: voteAverage,
            voteCount: voteCount,
            episodeRunTime: episodeRunTime.map { Int($0) },
            noOfSeasons: noOfSeasons,
            mediaType: mediaType)
    }
}

// MARK: - MovieTrailerEmbeddedObject

class MovieTrailerEmbeddedObject: EmbeddedObject {
    @Persisted var id: String?
    @Persisted var iso639_1: String?
    @Persisted var iso3166_1: String?
    @Persisted var keyPath: String?
    @Persisted var name: String?
    @Persisted var site: String?
    @Persisted var size: Int?
    @Persisted var type: String?
}
