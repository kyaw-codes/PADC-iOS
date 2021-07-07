//
//  ActorDetailResponse.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 07/07/2021.
//

import Foundation

// MARK: - ActorDetailResponse
struct ActorDetailResponse: Codable {
    let birthday, knownForDepartment: String?
    let deathday: String?
    let id: Int?
    let name: String?
    let alsoKnownAs: [String]?
    let gender: Int?
    let biography: String?
    let popularity: Double?
    let placeOfBirth, profilePath: String?
    let adult: Bool?
    let imdbID: String?
    let homepage: String?

    enum CodingKeys: String, CodingKey {
        case birthday
        case knownForDepartment = "known_for_department"
        case deathday, id, name
        case alsoKnownAs = "also_known_as"
        case gender, biography, popularity
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case adult
        case imdbID = "imdb_id"
        case homepage
    }
}
