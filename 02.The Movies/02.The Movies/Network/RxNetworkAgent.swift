//
//  RxNetworkAgent.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/08/2021.
//

import RxAlamofire
import RxSwift

protocol RxNetworkAgent {
    
    // MARK: - Movie
    func fetchMovies(withEndpoint endpoint: MDBEndPoint) -> Observable<MovieResponse>
    func fetchShowcaseMovies(withEndpoint endpoint: MDBEndPoint) -> Observable<MovieResponse>
    func searchMovie(with keyword: String, pageNo: Int) -> Observable<MovieResponse>
    func fetchSimilarMovies(ofMovieId id: Int, contentType: MovieFetchType) -> Observable<MovieResponse>
    func fetchMovieDetail(movieId id: Int, contentType: MovieFetchType) -> Observable<MovieDetailResponse>
    func fetchTrailer(movieId id: Int, contentType: MovieFetchType) -> Observable<Trailer>
    func fetchMoviesRelatedTo(actorId: Int) -> Observable<ActorCreditResponse>

    // MARK: - Actor
    func fetchActors(ofMovieId id: Int, contentType: MovieFetchType) -> Observable<[Actor]>
    func fetchActors(withEndpoint endpoint: MDBEndPoint) -> Observable<ActorResponse>
    func fetchActorDetail(actorId id: Int) -> Observable<ActorDetailResponse>

    // MARK: - Genres
    func fetchGenres(withEndpoint endpoint: MDBEndPoint) -> Observable<[Genre]>
}

// MARK: - Implementation

class RxNetworkAgentImpl: RxNetworkAgent {
    
    static let shared: RxNetworkAgent = RxNetworkAgentImpl()
    
    private init() {}
    
    func fetchMovies(withEndpoint endpoint: MDBEndPoint) -> Observable<MovieResponse> {
        RxAlamofire.requestDecodable(endpoint)
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchShowcaseMovies(withEndpoint endpoint: MDBEndPoint) -> Observable<MovieResponse> {
        RxAlamofire.requestDecodable(endpoint)
            .flatMap { Observable.just($0.1) }
    }
    
    func searchMovie(with keyword: String, pageNo: Int = 1) -> Observable<MovieResponse> {
        RxAlamofire.requestDecodable(MDBEndPoint.searchMovies(keyword: keyword))
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchSimilarMovies(ofMovieId id: Int, contentType: MovieFetchType) -> Observable<MovieResponse> {
        RxAlamofire.requestDecodable(MDBEndPoint.similarMovies(movieId: id, contentType: contentType))
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchMovieDetail(movieId id: Int, contentType: MovieFetchType) -> Observable<MovieDetailResponse> {
        RxAlamofire.requestDecodable(MDBEndPoint.movieDetail(id: id, contentType: contentType))
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchTrailer(movieId id: Int, contentType: MovieFetchType) -> Observable<Trailer> {
        RxAlamofire.requestDecodable(MDBEndPoint.movieTrailer(movieId: id, contentType: contentType))
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchMoviesRelatedTo(actorId: Int) -> Observable<ActorCreditResponse> {
        RxAlamofire.requestDecodable(MDBEndPoint.moviesOfAnActor(actorId: actorId))
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchActors(ofMovieId id: Int, contentType: MovieFetchType) -> Observable<[Actor]> {
        RxAlamofire.requestDecodable(MDBEndPoint.actorsOfAMovie(movieId: id, contentType: contentType))
            .do { response in
                print(response)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .map { tuple -> MovieCreditResponse in
                return tuple.1
            }
            .flatMap { movieCreditResponse in
                return Observable.of(movieCreditResponse.convertToActor() ?? [Actor]())
            }
    }
    
    func fetchActors(withEndpoint endpoint: MDBEndPoint) -> Observable<ActorResponse> {
        RxAlamofire.requestDecodable(endpoint)
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchActorDetail(actorId id: Int) -> Observable<ActorDetailResponse> {
        RxAlamofire.requestDecodable(MDBEndPoint.actorDetail(actorId: id))
            .flatMap { Observable.just($0.1) }
    }
    
    func fetchGenres(withEndpoint endpoint: MDBEndPoint) -> Observable<[Genre]> {
        RxAlamofire.requestDecodable(endpoint)
            .compactMap { tuple -> MovieGenres in
                tuple.1
            }
            .flatMap { movieGenres in
                Observable.just(movieGenres.genres ?? [])
            }
    }
    
    
}
