//
//  GenreRepository.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 19/08/2021.
//

import RealmSwift

protocol GenreRepository {
    
    func saveGenres(genres: [Genre])
    func getGenres(completion: @escaping ([Genre]) -> Void)
}

final class GenreRepositoryImpl: BaseRepository, GenreRepository {

    static let shared = GenreRepositoryImpl()
    
    private override init() {
        super.init()
    }

    func saveGenres(genres: [Genre]) {
        do {
            /// Conver to genre object sequence
            let objs = genres.map { $0.convertToGenreObject() }
            /// Open the realm transiction
            try realm.write {
                /// Persist data
                realm.add(objs, update: .modified)
            }
        } catch {
            print("\(#function) \(error)")
        }
    }
    
    func getGenres(completion: @escaping ([Genre]) -> Void) {
        let genreObjs: Results<GenreObject> = realm.objects(GenreObject.self)
        completion(genreObjs.map { $0.convertToGenre() })
    }
}
