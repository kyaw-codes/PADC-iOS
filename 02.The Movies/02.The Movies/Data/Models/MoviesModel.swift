//
//  MoviesModel.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 17/08/2021.
//

import Foundation

protocol MoviesModel {
    
    func getSliderMovies(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func getPopularMovies(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func getPopularSeries(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func getShowcaseMovies(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func searchMovie(with keyword: String, pageNo: Int, _ completion: @escaping(Result<MovieResponse, Error>) -> Void)
    func getSimilarMovies(ofMovieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func getMovieDetail(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieDetailResponse, Error>) -> Void)
    func getTrailer(movieId: Int, contentType: MovieFetchType, completion: @escaping (Result<Trailer, Error>) -> Void)
    func getMovieCredits(ofMovieId id: Int, contentType: MovieFetchType, completion: @escaping (Result<[Actor], Error>) -> Void)
}

final class MoviesModelImpl: BaseModel, MoviesModel {
    
    static let shared: MoviesModel = MoviesModelImpl()
    private let movieRepo: MovieRepository = MovieRepositoryImpl.shared
    
    private override init() {
    }
    
    func getSliderMovies(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        networkAgent.fetchMovies(withEndpoint: .upComingMovies, pageNo: pageNo ?? 1) { [weak self] result in
            do {
                let response = try result.get()
                self?.movieRepo.saveMovies(type: .sliderMovies, pageNo: pageNo ?? 1, movies: response.movies)
                
                self?.movieRepo.getMovies(type: .sliderMovies, pageNo: pageNo ?? 1, { movies in
                    completion(.success(MovieResponse(dates: response.dates, page: response.page, movies: movies, totalPages: response.totalPages, totalResults: response.totalResults)))
                })
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getPopularMovies(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        networkAgent.fetchMovies(withEndpoint: .popularMovies, pageNo: pageNo ?? 1) { [weak self] result in
            do {
                let response = try result.get()
                self?.movieRepo.saveMovies(type: .popularMovies, pageNo: pageNo ?? 1, movies: response.movies)
                
                self?.movieRepo.getMovies(type: .popularMovies, pageNo: pageNo ?? 1, { movies in
                    completion(.success(MovieResponse(dates: response.dates, page: response.page, movies: movies, totalPages: response.totalPages, totalResults: response.totalResults)))
                })
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getPopularSeries(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        networkAgent.fetchMovies(withEndpoint: .popularSeries, pageNo: pageNo ?? 1) { [weak self] result in
            do {
                let response = try result.get()
                self?.movieRepo.saveMovies(type: .popularSeries, pageNo: pageNo ?? 1, movies: response.movies)
                
                self?.movieRepo.getMovies(type: .popularSeries, pageNo: pageNo ?? 1, { movies in
                    completion(.success(MovieResponse(dates: response.dates, page: response.page, movies: movies, totalPages: response.totalPages, totalResults: response.totalResults)))
                })
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getShowcaseMovies(pageNo: Int?, _ completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        networkAgent.fetchShowcaseMovies(withEndpoint: .showcaseMovies(pageNo: pageNo ?? 1)) { [weak self] result in
            do {
                let response = try result.get()
                self?.movieRepo.saveMovies(type: .showcaseMovies, pageNo: pageNo ?? 1, movies: response.movies)
                
                self?.movieRepo.getMovies(type: .showcaseMovies, pageNo: pageNo ?? 1, { movies in
                    completion(.success(MovieResponse(dates: response.dates, page: response.page, movies: movies, totalPages: response.totalPages, totalResults: response.totalResults)))
                })
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func searchMovie(with keyword: String, pageNo: Int, _ completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        networkAgent.searchMovie(with: keyword, pageNo: pageNo) { result in
            do {
                let movies = try result.get()
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getSimilarMovies(ofMovieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        networkAgent.fetchSimilarMovies(ofMovieId: id, contentType: contentType) { result in
            do {
                let movies = try result.get()
                completion(.success(movies))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getMovieDetail(movieId id: Int, contentType: MovieFetchType, _ completion: @escaping (Result<MovieDetailResponse, Error>) -> Void) {
        networkAgent.fetchMovieDetail(movieId: id, contentType: contentType) { [weak self] result in
            do {
                let movieResponse = try result.get()
                self?.movieRepo.saveMovieDetail(movieId: id, detail: movieResponse)
                self?.movieRepo.getMovieDetail(movieId: id, { detail in
                    guard let detail = detail else {
                        fatalError("Movie detail found nil")
                    }
                    
                    completion(.success(detail))
                })
            } catch {
                completion(.failure(error))
            }
        }
    }

    func getTrailer(movieId: Int, contentType: MovieFetchType, completion: @escaping (Result<Trailer, Error>) -> Void) {
        networkAgent.fetchTrailer(movieId: movieId, contentType: contentType) { result in
            do {
                let trailer = try result.get()
                completion(.success(trailer))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getMovieCredits(ofMovieId id: Int, contentType: MovieFetchType, completion: @escaping (Result<[Actor], Error>) -> Void) {
        networkAgent.fetchActors(ofMovieId: id, contentType: contentType) { result in
            do {
                let actors = try result.get()
                completion(.success(actors))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
