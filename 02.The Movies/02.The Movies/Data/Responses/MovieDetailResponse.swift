//
//  MovieDetailResponse.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 06/07/2021.
//

import Foundation
import RealmSwift

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
    
    func convertToMovieDetailEmbeddedObject() -> MovieDetailEmbeddedObject {
        let genreList = List<GenreObject>()
        genres?.map { $0.convertToGenreObject() }.forEach { genreList.append($0) }
        
        let companyList = List<ProductionCompanyEmbeddedObject>()
        productionCompanies?.map { $0.convertToProductionCompanyObj() }.forEach { companyList.append($0) }
        
        let countryList = List<ProductionCountryEmbeddedObject>()
        productionCountries?.map { $0.convertToProductionCountryObj() }.forEach { countryList.append($0) }
        
        let languageList = List<SpokenLanguageEmbeddedObject>()
        spokenLanguages?.map { $0.convertToSpokenLanguageObj() }.forEach { languageList.append($0) }
        
        let episodeRuntimeList = List<Int>()
        episodeRunTime?.forEach { episodeRuntimeList.append($0) }
        
        let obj = MovieDetailEmbeddedObject()
        obj.adult = adult
        obj.backdropPath = backdropPath
        obj.budget = budget
        obj.genres = genreList        
        obj.homepage = homepage
        obj.id = id
        obj.imdbID = imdbID
        obj.originalLanguage = originalLanguage
        obj.originalTitle = originalTitle
        obj.originalName = originalName
        obj.name = name
        obj.overview = overview
        obj.popularity = popularity
        obj.posterPath = posterPath
        obj.productionCompanies = companyList
        obj.productionCountries = countryList
        obj.releaseDate = releaseDate
        obj.lastAirDate = lastAirDate
        obj.revenue = revenue
        obj.runtime = runtime
        obj.spokenLanguages = languageList
        obj.status = status
        obj.tagline = tagline
        obj.title = title
        obj.video = video
        obj.voteAverage = voteAverage
        obj.voteCount = voteCount
        obj.episodeRunTime = episodeRuntimeList
        obj.noOfSeasons = noOfSeasons
        obj.mediaType = mediaType
        return obj
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
    
    func convertToProductionCompanyObj() -> ProductionCompanyEmbeddedObject {
        let obj = ProductionCompanyEmbeddedObject()
        obj.id = id
        obj.logoPath = logoPath
        obj.name = name
        obj.originCountry = originCountry
        return obj
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
    
    func convertToProductionCountryObj() -> ProductionCountryEmbeddedObject {
        let obj = ProductionCountryEmbeddedObject()
        obj.iso3166_1 = iso3166_1
        obj.name = name
        return obj
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
    
    func convertToSpokenLanguageObj() -> SpokenLanguageEmbeddedObject {
        let obj = SpokenLanguageEmbeddedObject()
        obj.englishName = englishName
        obj.iso639_1 = iso639_1
        obj.name = name
        return obj
    }
}
