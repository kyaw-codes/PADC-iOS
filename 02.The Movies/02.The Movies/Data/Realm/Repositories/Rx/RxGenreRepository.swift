//
//  RxGenreRepository.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/08/2021.
//

import RxRealm
import RealmSwift
import RxSwift

protocol RxGenreRepository {
    func saveGenres(genres: [Genre])
    func getGenres() -> Observable<[Genre]>
}

final class RxGenreRepositoryImpl: BaseRepository, RxGenreRepository {

    static let shared: RxGenreRepository = RxGenreRepositoryImpl()
    
    private override init() {
        super.init()
    }

    func saveGenres(genres: [Genre]) {
        do {
            /// Convert to genre object sequence
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
    
    func getGenres() -> Observable<[Genre]> {
        let collection: Results<GenreObject> = realm.objects(GenreObject.self)
        return Observable.collection(from: collection)
            .flatMap { objects -> Observable<[Genre]> in
                return Observable.of(objects.map { $0.convertToGenre() })
            }
    }
    
}
