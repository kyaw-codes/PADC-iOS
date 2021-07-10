//
//  MovieDbService.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 24/06/2021.
//

import Foundation
import Alamofire

final class MovieDbService {
    
    static let shared: MovieDbService = MovieDbService()
    
    enum ContentType: String {
        case movie = "movie"
        case tv = "tv"
    }
    
    private init() {}
    
    /// Fetch all movies
    /// - Parameters:
    ///   - subPath: The sub path to fetch movies. The movies could be latest  or top rated or upcoming or something
    ///   - pageNo: The page nunber you want to fetch
    ///   - completion: Pass Result<Array<Movie>, AFError> as a parameter
    func fetchMovies(with subPath: String, pageNo: Int = 1, _ completion: @escaping (Result<Array<Movie>, AFError>) -> Void) {
        AF.request("\(composeUrlString(subPath: subPath))&page=\(pageNo)").responseDecodable(of: MovieResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let movies = response.value {
                completion(.success(movies.movies))
            }
        }.validate(statusCode: 200..<300)
    }
    
    /// Fetch movies for show case section
    /// - Parameters:
    ///   - subPath: The sub path to fetch movies. The movies could be latest  or top rated or upcoming or something
    ///   - completion: Pass Result<MovieResponse, AFError> as a parameter
    func fetchShowcaseMovies(with subPath: String, _ completion: @escaping (Result<MovieResponse, AFError>) -> Void) {
        AF.request(composeUrlString(subPath: subPath)).responseDecodable(of: MovieResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let movieResponse = response.value {
                completion(.success(movieResponse))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func searchMovie(with keyword: String, pageNo: Int = 1, _ completion: @escaping(Result<MovieResponse, AFError>) -> Void) {
        AF.request("\(composeUrlString(subPath: "search/movie/"))&query=\(keyword)").responseDecodable(of: MovieResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let movieResponse = response.value {
                completion(.success(movieResponse))
            }
        }.validate(statusCode: 200..<300)
    }
    
    
    /// Fetch an actor with specific id
    /// - Parameters:
    ///   - id: Actor id
    ///   - contentType: He could be acting in either movies or series
    ///   - completion: Pass Result<Array<Actor>, AFError> as a parameter
    func fetchActor(of id: Int, contentType: ContentType = .movie, _ completion: @escaping (Result<Array<Actor>, AFError>) -> Void) {
        AF.request(composeUrlString(subPath: "\(contentType.rawValue)/\(id)/credits")).responseDecodable(of: MovieCreditResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let response = response.value,
                let actors = response.convertToActor() {
                completion(.success(actors))
            }
        }.validate(statusCode: 200..<300)
    }
    
    
    /// Fetch detail of a movie
    /// - Parameters:
    ///   - id: The movie id
    ///   - contentType: The type of a movie (It could be movie or tv)
    ///   - completion: Pass Result<MovieDetailResponse, AFError> as a parameter
    func fetchMovie(of id: Int, contentType: ContentType = .movie, _ completion: @escaping (Result<MovieDetailResponse, AFError>) -> Void) {
        AF.request(composeUrlString(subPath: "\(contentType.rawValue)/\(id)")).responseDecodable(of: MovieDetailResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let detail = response.value {
                completion(.success(detail))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchTrailer(of id: Int, contentType: ContentType = .movie, _ completion: @escaping (Result<Trailer, AFError>) -> Void) {
        AF.request(composeUrlString(subPath: "\(contentType.rawValue)/\(id)/videos")).responseDecodable(of: MovieTrailerResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let trailerResponse = response.value,
                let trailer = trailerResponse.results?.first {
                completion(.success(trailer))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchActorDetail(actorId id: Int, _ completion: @escaping(Result<ActorDetailResponse, AFError>) -> Void) {
        AF.request(composeUrlString(subPath: "person/\(id)")).responseDecodable(of: ActorDetailResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let actorResponse = response.value {
                completion(.success(actorResponse))
            }
        }.validate(statusCode: 200..<300)
    }
    
    
    /// Fetch movies related to an actor/actress
    /// - Parameters:
    ///   - actorId: Id of an actor
    ///   - completion: Pass Result<ActorCreditResponse, AFError>
    func fetchMovies(of actorId: Int, _ completion: @escaping(Result<ActorCreditResponse, AFError>) -> Void) {
        AF.request(composeUrlString(subPath: "person/\(actorId)/combined_credits")).responseDecodable(of: ActorCreditResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let actorResponse = response.value {
                completion(.success(actorResponse))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchSimilarMovies(of id: Int, contentType: ContentType = .movie, _ completion: @escaping (Result<Array<Movie>, AFError>) -> Void) {
        AF.request(composeUrlString(subPath: "\(contentType.rawValue)/\(id)/recommendations")).responseDecodable(of: MovieResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let detail = response.value {
                completion(.success(detail.movies))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchGenres(with subPath: String, _ completion: @escaping (Result<Array<Genre>, AFError>) -> Void) {
        AF.request(composeUrlString(subPath: subPath)).responseDecodable(of: MovieGenres.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let genre = response.value,
                let genres = genre.genres {
                completion(.success(genres))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchActors(with subPath: String, pageNo: Int = 1, _ completion: @escaping (Result<ActorResponse, AFError>) -> Void) {
        AF.request("\(composeUrlString(subPath: subPath))&page=\(pageNo)").responseDecodable(of: ActorResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let actorResponse = response.value {
                completion(.success(actorResponse))
            }
        }.validate(statusCode: 200..<300)
    }
    
    private func composeUrlString(subPath: String) -> String {
        let path = subPath.first == "/" ? subPath : "/\(subPath)"
        return "\(baseURL)\(path)?api_key=\(apiKey)"
    }
}
