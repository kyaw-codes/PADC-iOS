//
//  Models.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 24/06/2021.
//

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let dates: Dates
    let page: Int
    let movieList: [MovieList]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movieList = "results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - MovieList
struct MovieList: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

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
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
}
