//
//  GenreObject.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 18/08/2021.
//

import RealmSwift

class GenreObject: Object {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    
    func convertToGenre() -> Genre {
        Genre(id: id, name: name)
    }
}
