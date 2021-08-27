//
//  ActorResponse.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 06/07/2021.
//

import RealmSwift

// MARK: - ActorResponse
struct ActorResponse: Codable {
    let page: Int?
    let actors: [Actor]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case actors = "results"
    }
}

// MARK: - Actor
struct Actor: Codable {
    let gender: Int?
    let id: Int
    let movies: [Movie]?
    let role: String?
    let name: String?
    let popularity: Double?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case gender
        case id
        case movies = "known_for"
        case role = "known_for_department"
        case name
        case popularity
        case profilePath = "profile_path"
    }
    
    func convertToActorObject(pageNo: Int) -> ActorObject {
        let object = ActorObject()
        
        let movieObjs = List<MovieObject>()
        movies?.map { $0.convertToMovieObj(type: .others) }.forEach { movieObjs.append($0) }
        
        object.gender = gender
        object.id = id
        object.movies = movieObjs
        object.role = role
        object.name = name
        object.popularity = popularity
        object.profilePath = profilePath
        object.pageNo = pageNo
        return object
    }
}
