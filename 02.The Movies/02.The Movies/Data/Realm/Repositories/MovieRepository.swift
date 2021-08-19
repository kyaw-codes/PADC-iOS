//
//  MovieRepository.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 19/08/2021.
//

import RealmSwift

protocol MovieRepository {
    func saveMovies(type: MovieDisplayType, pageNo: Int, movies: [Movie])
    func getMovies(type: MovieDisplayType, pageNo: Int, _ completion: @escaping ([Movie]) -> Void)
    func getMovieDetail(movieId id: Int, _ completion: @escaping (MovieDetailResponse?) -> Void)
    
//    func getSimilarMovies(ofMovieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func saveMovieDetail(movieId id: Int, detail: MovieDetailResponse)
//    func getMovieDetail(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieDetailResponse, Error>) -> Void)
//    func getTrailer(movieId: Int, contentType: MovieFetchType, completion: @escaping (Result<Trailer, Error>) -> Void)
//    func getMovieCredits(ofMovieId id: Int, contentType: MovieFetchType, completion: @escaping (Result<[Actor], Error>) -> Void)
}

final class MovieRepositoryImpl: BaseRepository, MovieRepository {

    static let shared = MovieRepositoryImpl()
    
    private override init() {
    }

    func saveMovies(type: MovieDisplayType, pageNo: Int = 1, movies: [Movie]) {
        do {
            let movieObjs = movies.map { $0.convertToMovieObj(type: type, pageNo: pageNo) }
            try realm.write {
                realm.add(movieObjs, update: .modified)
            }
        } catch {
            print("\(#function) \(error)")
        }
    }
    
    func getMovies(type: MovieDisplayType, pageNo: Int = 1, _ completion: @escaping ([Movie]) -> Void) {
        let predicate = NSPredicate(format: "displayType = %@ && pageNo = %d", type.rawValue, pageNo)
        let objects: Results<MovieObject> = realm.objects(MovieObject.self).filter(predicate)
        completion(objects.map { $0.convertToMovie() })
    }
    
    func saveMovieDetail(movieId id: Int, detail: MovieDetailResponse) {
        findMovieById(id) { [weak self] movie in
            guard let movieObj = movie else { return }
            
            do {
                try self?.realm.write {
                    movieObj.detail = detail.convertToMovieDetailEmbeddedObject()                    
                    self?.realm.add(movieObj.detail!.genres, update: .modified)
                    self?.realm.add(movieObj, update: .modified)
                }
            } catch {
                print("\(#function) \(error)")
            }
        }
    }
    
    func getMovieDetail(movieId id: Int, _ completion: @escaping (MovieDetailResponse?) -> Void) {
        findMovieById(id) { movie in
            completion(movie?.detail?.convertToMovieDetail())
        }
    }
    
    private func findMovieById(_ id: Int, completion: @escaping (MovieObject?) -> Void) {
        completion(realm.object(ofType: MovieObject.self, forPrimaryKey: id))
    }

}
