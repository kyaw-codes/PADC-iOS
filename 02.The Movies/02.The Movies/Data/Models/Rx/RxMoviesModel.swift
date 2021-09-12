//
//  RxMoviesModel.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 01/09/2021.
//

import RxSwift

protocol RxMoviesModel {
    
    func getSliderMovies(pageNo: Int?) -> Observable<MovieResponse>
    func getPopularMovies(pageNo: Int?) -> Observable<MovieResponse>
    func getPopularSeries(pageNo: Int?) -> Observable<MovieResponse>
    func getShowcaseMovies(pageNo: Int?) -> Observable<MovieResponse>
    func searchMovie(with keyword: String, pageNo: Int) -> Observable<MovieResponse>
    func getSimilarMovies(ofMovieId id: Int, contentType: MovieFetchType) -> Observable<MovieResponse>
    func getMovieDetail(movieId id: Int, contentType: MovieFetchType) -> Observable<MovieDetailResponse?>
    func getTrailer(movieId: Int, contentType: MovieFetchType) -> Observable<Trailer>
    func getMovieCredits(ofMovieId id: Int, contentType: MovieFetchType) -> Observable<[Actor]>
}

final class RxMoviesModelImpl: BaseModel, RxMoviesModel {
    
    static let shared: RxMoviesModel = RxMoviesModelImpl()
    
    private let rxMovieRepo = RxMovieRepositoryImpl.shared
    
    private override init() {
    }
    
    func getSliderMovies(pageNo: Int?) -> Observable<MovieResponse> {
        rxNetworkAgent.fetchMovies(withEndpoint: .upComingMovies)
            .do { [weak self] response in
                self?.rxMovieRepo.saveMovies(type: .sliderMovies, pageNo: pageNo ?? 1, movies: response.movies)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { response -> Observable<MovieResponse> in
                return self.rxMovieRepo.getMovies(type: .sliderMovies, pageNo: pageNo ?? 1)
                    .flatMap{ movies in
                        return Observable.of(MovieResponse(dates: response.dates, page: response.page, movies: movies, totalPages: response.totalPages, totalResults: response.totalResults))
                    }
            }
    }
    
    func getPopularMovies(pageNo: Int?) -> Observable<MovieResponse> {
        rxNetworkAgent.fetchMovies(withEndpoint: .popularMovies)
            .do { [weak self] response in
                self?.rxMovieRepo.saveMovies(type: .popularMovies, pageNo: pageNo ?? 1, movies: response.movies)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { response -> Observable<MovieResponse> in
                return self.rxMovieRepo.getMovies(type: .popularMovies, pageNo: pageNo ?? 1)
                    .flatMap { movies in
                        return Observable.of(MovieResponse(dates: response.dates, page: response.page, movies: movies, totalPages: response.totalPages, totalResults: response.totalResults))
                    }
            }
    }
    
    func getPopularSeries(pageNo: Int?) -> Observable<MovieResponse> {
        rxNetworkAgent.fetchMovies(withEndpoint: .popularSeries)
            .do { [weak self] response in
                self?.rxMovieRepo.saveMovies(type: .popularSeries, pageNo: pageNo ?? 1, movies: response.movies)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { response -> Observable<MovieResponse> in
                return self.rxMovieRepo.getMovies(type: .popularSeries, pageNo: pageNo ?? 1)
                    .flatMap { movies in
                        return Observable.of(MovieResponse(dates: response.dates, page: response.page, movies: movies, totalPages: response.totalPages, totalResults: response.totalResults))
                    }
            }
    }

    func getShowcaseMovies(pageNo: Int?) -> Observable<MovieResponse> {
        rxNetworkAgent.fetchMovies(withEndpoint: .showcaseMovies(pageNo: pageNo ?? 1))
            .do { [weak self] response in
                self?.rxMovieRepo.saveMovies(type: .showcaseMovies, pageNo: pageNo ?? 1, movies: response.movies)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { response -> Observable<MovieResponse> in
                return self.rxMovieRepo.getMovies(type: .popularMovies, pageNo: pageNo ?? 1)
                    .flatMap { movies in
                        return Observable.of(MovieResponse(dates: response.dates, page: response.page, movies: movies, totalPages: response.totalPages, totalResults: response.totalResults))
                    }
            }
    }

    func searchMovie(with keyword: String, pageNo: Int) -> Observable<MovieResponse> {
        rxNetworkAgent.searchMovie(with: keyword, pageNo: pageNo)
    }

    func getSimilarMovies(ofMovieId id: Int, contentType: MovieFetchType) -> Observable<MovieResponse> {
        rxNetworkAgent.fetchSimilarMovies(ofMovieId: id, contentType: contentType)
            .do { [weak self] response in
                self?.rxMovieRepo.saveMovies(type: .similarMoves, pageNo: 1, movies: response.movies)
            } onError: { error in
                print("\(#function) \(error)")
            }
    }

    func getMovieDetail(movieId id: Int, contentType: MovieFetchType) -> Observable<MovieDetailResponse?> {
        rxNetworkAgent.fetchMovieDetail(movieId: id, contentType: contentType)
            .do { [weak self] response in
                self?.rxMovieRepo.saveMovieDetail(movieId: id, detail: response)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .flatMap { response -> Observable<MovieDetailResponse?> in
                self.rxMovieRepo.getMovieDetail(movieId: response.id ?? -1)
            }
    }

    func getTrailer(movieId: Int, contentType: MovieFetchType) -> Observable<Trailer> {
        rxNetworkAgent.fetchTrailer(movieId: movieId, contentType: contentType)
    }

    func getMovieCredits(ofMovieId id: Int, contentType: MovieFetchType) -> Observable<[Actor]> {
        rxNetworkAgent.fetchActors(ofMovieId: id, contentType: contentType)
    }
    
}
