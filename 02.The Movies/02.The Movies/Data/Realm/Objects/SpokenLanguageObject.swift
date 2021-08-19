//
//  SpokenLanguageObject.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 18/08/2021.
//

import RealmSwift

class SpokenLanguageObject: Object {
    @Persisted(primaryKey: true) var name: String?
    @Persisted var  englishName: String?
    @Persisted var iso639_1: String?
}
