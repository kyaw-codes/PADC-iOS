//
//  ActorDetailResponse.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 07/07/2021.
//

import RealmSwift

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

    static let emptyObj = ActorDetailResponse(birthday: nil, knownForDepartment: nil, deathday: nil, id: nil, name: nil, alsoKnownAs: nil, gender: nil, biography: nil, popularity: nil, placeOfBirth: nil, profilePath: nil, adult: nil, imdbID: nil, homepage: nil)

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
    
    func convertToActorDetailObj() -> ActorDetailEmbeddedObject {
        let obj = ActorDetailEmbeddedObject()
        
        let akaList = List<String>()
        alsoKnownAs?.forEach { akaList.append($0) }

        obj.id = id
        obj.birthday = birthday
        obj.knownForDepartment = knownForDepartment
        obj.deathday = deathday
        obj.name = name
        obj.alsoKnownAs = akaList
        obj.gender = gender
        obj.biography = biography
        obj.popularity = popularity
        obj.placeOfBirth = placeOfBirth
        obj.profilePath = profilePath
        obj.adult = adult
        obj.imdbID = imdbID
        obj.homepage = homepage
        return obj
    }
}
