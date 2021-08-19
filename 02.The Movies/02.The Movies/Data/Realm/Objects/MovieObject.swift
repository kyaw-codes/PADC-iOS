//
//  MovieObject.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 18/08/2021.
//

import RealmSwift

class MovieObject: Object {
    
    @Persisted(primaryKey: true) var id: Int?
    @Persisted var adult: Bool?
    @Persisted var backdropPath: String?
    @Persisted var genreIDS: List<Int>
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
    @Persisted(originProperty: "movies") var actors: LinkingObjects<ActorObject>
    @Persisted var trailer: MovieTrailerEmbeddedObject?
    @Persisted var detail: MovieDetailEmbeddedObject?
    @Persisted var displayType: MovieDisplayType?
}

class MovieDetailEmbeddedObject: EmbeddedObject {
    
    @Persisted var adult: Bool?
    @Persisted var backdropPath: String?
    @Persisted var budget: Int?
    @Persisted(originProperty: "movies") var genres: LinkingObjects<GenreObject>
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
    @Persisted var productionCompanies: List<ProductionCompanyObject>
    @Persisted var productionCountries: List<ProductionCountryObject>
    @Persisted var releaseDate: String?
    @Persisted var lastAirDate: String?
    @Persisted var revenue: Int?
    @Persisted var runtime: Int?
    @Persisted var spokenLanguages: List<SpokenLanguageObject>
    @Persisted var status: String?
    @Persisted var tagline: String?
    @Persisted var title: String?
    @Persisted var video: Bool?
    @Persisted var voteAverage: Double?
    @Persisted var voteCount: Int?
    @Persisted var episodeRunTime: List<Int>
    @Persisted var noOfSeasons: Int?
    @Persisted var mediaType: String?
}

class MovieTrailerEmbeddedObject: EmbeddedObject {
    @Persisted(primaryKey: true) var id: String?
    @Persisted var iso639_1: String?
    @Persisted var iso3166_1: String?
    @Persisted var keyPath: String?
    @Persisted var name: String?
    @Persisted var site: String?
    @Persisted var size: Int?
    @Persisted var type: String?
}
