//
//  ActorObject.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 18/08/2021.
//

import RealmSwift

class ActorObject: Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var gender: Int?
    @Persisted var movies: List<MovieObject>
    @Persisted var role: String?
    @Persisted var name: String?
    @Persisted var popularity: Double?
    @Persisted var profilePath: String?
    @Persisted var detail: ActorDetailEmbeddedObject?
}

class ActorDetailEmbeddedObject: EmbeddedObject {
    
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
}
