//
//  MovieVO.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 15/08/2021.
//

import Foundation

struct MovieVO {
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath, releaseDate, name, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
}
