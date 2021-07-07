//
//  ActorCreditResponse.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 07/07/2021.
//

import Foundation

struct ActorCreditResponse: Codable {
    
    var movies: [MovieDetailResponse]?
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case movies = "cast"
    }
}
