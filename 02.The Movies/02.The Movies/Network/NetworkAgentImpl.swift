//
//  NetworkAgentImpl.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 24/06/2021.
//

import Foundation
import Alamofire

final class NetworkAgentImpl: NetworkAgent {

    static let shared: NetworkAgentImpl = NetworkAgentImpl()
    
    private init() {}
    
    func fetchMovies(withEndpoint endpoint: MDBEndPoint, pageNo: Int = 1, _ completion: @escaping (Result<MovieResponse, AFError>) -> Void) {
        AF.request(endpoint.urlString).responseDecodable(of: MovieResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let movies = response.value {
                completion(.success(movies))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchShowcaseMovies(withEndpoint endpoint: MDBEndPoint, _ completion: @escaping (Result<MovieResponse, AFError>) -> Void) {
        AF.request(endpoint.urlString).responseDecodable(of: MovieResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let movieResponse = response.value {
                completion(.success(movieResponse))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func searchMovie(with keyword: String, pageNo: Int = 1, _ completion: @escaping(Result<MovieResponse, AFError>) -> Void) {
        AF.request(MDBEndPoint.searchMovies(keyword: keyword).urlString).responseDecodable(of: MovieResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let movieResponse = response.value {
                completion(.success(movieResponse))
            }
        }.validate(statusCode: 200..<300)
    }
    
    
    func fetchMovieDetail(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieDetailResponse, AFError>) -> Void) {
        let urlString = MDBEndPoint.movieDetail(id: id, contentType: contentType).urlString
        AF.request(urlString).responseDecodable(of: MovieDetailResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let detail = response.value {
                completion(.success(detail))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchMoviesRelatedTo(actorId: Int, _ completion: @escaping (Result<ActorCreditResponse, AFError>) -> Void) {
        AF.request(MDBEndPoint.moviesOfAnActor(actorId: actorId).urlString).responseDecodable(of: ActorCreditResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let actorResponse = response.value {
                completion(.success(actorResponse))
            }
        }.validate(statusCode: 200..<300)
    }

    func fetchActors(ofMovieId id: Int, contentType: MovieFetchType = .movie, _ completion: @escaping (Result<Array<Actor>, AFError>) -> Void) {
        let url = MDBEndPoint.actorsOfAMovie(movieId: id, contentType: contentType)
        AF.request(url.urlString).responseDecodable(of: MovieCreditResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }

            if let response = response.value,
                let actors = response.convertToActor() {
                completion(.success(actors))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchTrailer(movieId id: Int, contentType: MovieFetchType = .movie, _ completion: @escaping (Result<Trailer, AFError>) -> Void) {
        let url = MDBEndPoint.movieTrailer(movieId: id, contentType: contentType).urlString
        AF.request(url).responseDecodable(of: MovieTrailerResponse.self) { response in
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
        let url = MDBEndPoint.actorDetail(actorId: id).urlString
        AF.request(url).responseDecodable(of: ActorDetailResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let actorResponse = response.value {
                completion(.success(actorResponse))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchSimilarMovies(ofMovieId id: Int, contentType: MovieFetchType = .movie, _ completion: @escaping (Result<MovieResponse, AFError>) -> Void) {
        let url = MDBEndPoint.similarMovies(movieId: id, contentType: contentType).urlString
        AF.request(url).responseDecodable(of: MovieResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let response = response.value {
                completion(.success(response))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchGenres(withEndpoint endpoint: MDBEndPoint, _ completion: @escaping (Result<Array<Genre>, AFError>) -> Void) {
        AF.request(endpoint.urlString).responseDecodable(of: MovieGenres.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let genre = response.value,
                let genres = genre.genres {
                completion(.success(genres))
            }
        }.validate(statusCode: 200..<300)
    }
    
    func fetchActors(withEndpoint endpoint: MDBEndPoint, _ completion: @escaping (Result<ActorResponse, AFError>) -> Void) {
        AF.request(endpoint.urlString).responseDecodable(of: ActorResponse.self) { response in
            if let error = response.error {
                completion(.failure(error))
            }
            
            if let actorResponse = response.value {
                completion(.success(actorResponse))
            }
        }.validate(statusCode: 200..<300)
    }

}
