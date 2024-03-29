//
//  SpokenLanguageObject.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 18/08/2021.
//

import RealmSwift

class SpokenLanguageEmbeddedObject: EmbeddedObject {
    @Persisted var name: String?
    @Persisted var  englishName: String?
    @Persisted var iso639_1: String?
    
    func convertToSpokenLanguage() -> SpokenLanguage {
        SpokenLanguage(englishName: englishName, iso639_1: iso639_1, name: name)
    }
}
