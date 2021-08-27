//
//  ActorObject.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 18/08/2021.
//

import RealmSwift

// MARK: - ActorObject

class ActorObject: Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var gender: Int?
    @Persisted var movies: List<MovieObject>
    @Persisted var role: String?
    @Persisted var name: String?
    @Persisted var popularity: Double?
    @Persisted var profilePath: String?
    @Persisted var detail: ActorDetailEmbeddedObject?
    @Persisted var pageNo: Int?
    
    func convertToActor() -> Actor {
        Actor(gender: gender,
              id: id,
              movies: movies.map { $0.convertToMovie() },
              role: role,
              name: name,
              popularity: popularity,
              profilePath: profilePath)
    }
}

// MARK: - ActorDetailEmbeddedObject

class ActorDetailEmbeddedObject: EmbeddedObject {
    
    @Persisted var id: Int?
    @Persisted var birthday: String?
    @Persisted var knownForDepartment: String?
    @Persisted var deathday: String?
    @Persisted var name: String?
    @Persisted var alsoKnownAs: List<String>
    @Persisted var gender: Int?
    @Persisted var biography: String?
    @Persisted var popularity: Double?
    @Persisted var placeOfBirth: String?
    @Persisted var profilePath: String?
    @Persisted var adult: Bool?
    @Persisted var imdbID: String?
    @Persisted var homepage: String?
    
    func convertToActorDetailResponse() -> ActorDetailResponse {
        ActorDetailResponse(birthday: birthday,
                            knownForDepartment: knownForDepartment,
                            deathday: deathday,
                            id: id,
                            name: name,
                            alsoKnownAs: alsoKnownAs.map { String($0) },
                            gender: gender,
                            biography: biography,
                            popularity: popularity,
                            placeOfBirth: placeOfBirth,
                            profilePath: profilePath,
                            adult: adult,
                            imdbID: imdbID,
                            homepage: homepage)
    }
}
