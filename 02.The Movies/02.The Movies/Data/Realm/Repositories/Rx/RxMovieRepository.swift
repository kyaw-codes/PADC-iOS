//
//  RxMovieRepository.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 01/09/2021.
//

import Foundation
import RxSwift
import RxRealm

protocol RxMovieRepository {
    func saveMovies(type: MovieDisplayType, pageNo: Int, movies: [Movie])
    func saveMovieDetail(movieId id: Int, detail: MovieDetailResponse)
    func getMovies(type: MovieDisplayType, pageNo: Int) -> Observable<[Movie]>
    func getMovieDetail(movieId id: Int) -> Observable<MovieDetailResponse?>
}

final class RxMovieRepositoryImpl: BaseRepository, RxMovieRepository {
    
    static let shared: RxMovieRepository = RxMovieRepositoryImpl()
    
    private override init() {
    }
    
    func saveMovies(type: MovieDisplayType, pageNo: Int, movies: [Movie]) {
        let objects = movies.map { $0.convertToMovieObj(type: type) }

        do {
            try realm.write { realm.add(objects, update: .modified) }
        } catch {
            print("\(#function) \(error)")
        }
        
    }
    
    func saveMovieDetail(movieId id: Int, detail: MovieDetailResponse) {
        let detailObj = detail.convertToMovieDetailEmbeddedObject()
        do {
            try realm.write {
                let movie = realm.object(ofType: MovieObject.self, forPrimaryKey: id)
                movie?.detail = detailObj
            }
        } catch {
            print("\(#function) \(error)")
        }
    }
    
    func getMovies(type: MovieDisplayType, pageNo: Int) -> Observable<[Movie]> {
        let predicate = NSPredicate(format: "displayType = %@ && pageNo = %d", type.rawValue, pageNo)
        let moviesCollection = realm.objects(MovieObject.self).filter(predicate).sorted(byKeyPath: "releaseDate")
        
        return Observable.collection(from: moviesCollection)
            .flatMap { objects -> Observable<[Movie]> in
                Observable.of(objects.map { $0.convertToMovie() })
            }
    }
    
    func getMovieDetail(movieId id: Int) -> Observable<MovieDetailResponse?> {
        let movieObject = realm.object(ofType: MovieObject.self, forPrimaryKey: id)
        return Observable.of(movieObject?.detail?.convertToMovieDetail())
    }
    
    
}
