//
//  MovieDetailResponse.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 06/07/2021.
//

import Foundation

// MARK: - MovieDetailResponse
struct MovieDetailResponse: Codable {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, originalName, name, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let lastAirDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let episodeRunTime: [Int]?
    let noOfSeasons: Int?
    let mediaType: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case originalName = "original_name"
        case name
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case lastAirDate = "last_air_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case episodeRunTime = "episode_run_time"
        case noOfSeasons = "number_of_seasons"
        case mediaType = "media_type"
    }
    
    func convertToMovie() -> Movie {
        Movie(adult: self.adult,
              backdropPath: self.backdropPath,
              genreIDS: nil, id: self.id,
              originalLanguage: self.originalLanguage,
              originalTitle: self.originalTitle,
              overview: self.overview,
              popularity: self.popularity,
              posterPath: self.posterPath,
              releaseDate: self.releaseDate,
              name: self.name,
              title: self.title,
              video: self.video,
              voteAverage: self.voteAverage,
              voteCount: self.voteCount,
              mediaType: self.mediaType)
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int?
    let logoPath, name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
