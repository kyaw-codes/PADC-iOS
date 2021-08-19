//
//  MovieResponse.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 24/06/2021.
//

import Foundation
import RealmSwift

// MARK: - MovieResponse
struct MovieResponse: Codable {
    let dates: Dates?
    let page: Int?
    let movies: [Movie]
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movies = "results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - Movie
struct Movie: Codable, Hashable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, name, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let mediaType: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video, name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case mediaType = "media_type"
    }
    
    func convertToMovieObj(type: MovieDisplayType, pageNo: Int = 1) -> MovieObject {
        let obj = MovieObject()
        obj.adult = adult
        obj.backdropPath = backdropPath
        obj.genreIDS = genreIDS?.map { String($0) }.joined(separator: ",") ?? ""
        obj.id = id
        obj.originalLanguage = originalLanguage
        obj.originalTitle = originalTitle
        obj.overview = overview
        obj.popularity = popularity
        obj.posterPath = posterPath
        obj.releaseDate = releaseDate
        obj.name = name
        obj.title = title
        obj.video = video
        obj.voteAverage = voteAverage
        obj.voteCount = voteCount
        obj.mediaType = mediaType
        obj.displayType = type
        obj.pageNo = pageNo
        return obj
    }
}

// MARK: - MovieGenres
struct MovieGenres: Codable {
    let genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
    
    func convertToVO() -> GenreVO {
        GenreVO(id: id, genreName: name, isSelected: false)
    }
    
    func convertToGenreObject() -> GenreObject {
        let object = GenreObject()
        object.id = id
        object.name = name
        return object
    }
}
