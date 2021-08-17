//
//  NetworkAgent.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 15/08/2021.
//

import Alamofire

protocol NetworkAgent {
    
    // MARK: - Movie
    func fetchMovies(withEndpoint endpoint: MDBEndPoint, pageNo: Int, _ completion: @escaping (Result<MovieResponse, AFError>) -> Void)
    func fetchShowcaseMovies(withEndpoint endpoint: MDBEndPoint, _ completion: @escaping (Result<MovieResponse, AFError>) -> Void)
    func searchMovie(with keyword: String, pageNo: Int, _ completion: @escaping(Result<MovieResponse, AFError>) -> Void)
    func fetchSimilarMovies(ofMovieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieResponse, AFError>) -> Void)
    func fetchMovieDetail(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieDetailResponse, AFError>) -> Void)
    
    // MARK: - Actor    
    func fetchActors(ofMovieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<Array<Actor>, AFError>) -> Void)
    func fetchActors(withEndpoint endpoint: MDBEndPoint, _ completion: @escaping (Result<ActorResponse, AFError>) -> Void)
    func fetchActorDetail(actorId id: Int, _ completion: @escaping(Result<ActorDetailResponse, AFError>) -> Void)

    func fetchTrailer(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<Trailer, AFError>) -> Void)
    func fetchMoviesRelatedTo(actorId: Int, _ completion: @escaping(Result<ActorCreditResponse, AFError>) -> Void)

    // MARK: - Genres
    func fetchGenres(withEndpoint endpoint: MDBEndPoint, _ completion: @escaping (Result<Array<Genre>, AFError>) -> Void)
}
