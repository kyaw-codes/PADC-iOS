//
//  Models.swift
//  03.Networking and API
//
//  Created by Ko Kyaw on 13/06/2021.
//

import Foundation

struct MovieResult: Codable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Codable {
    let name: String?
    let releaseDate: String?
    let voteAverage: Double?
    var posterPath: String?
    let overview: String?
    let adult: Bool

    enum CodingKeys: String, CodingKey {
        case name = "title"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case overview
        case adult
    }
}

enum TrendingMovieError: Error {
    case invalidResponse(message: String)
    case invalidContentType(message: String)
    case decodingError(message: String)
}
