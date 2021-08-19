//
//  BaseRepository.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 19/08/2021.
//

import RealmSwift

class BaseRepository {
    
    let realm = try! Realm()
    
    private init() {
        print("Default Realm file location: \(realm.configuration.fileURL?.absoluteString ?? "undefined")")
    }
}
