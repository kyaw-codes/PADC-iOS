//
//  HomeViewController+Networking.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import Foundation

extension HomeViewController {

    fileprivate func loadSliderMovies() {
        // Fetch slider movies
        rxMovieModel.getSliderMovies(pageNo: nil)
            .subscribe { [weak self] response in
                self?.observableSliderMovies.onNext(response.movies)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func loadPopularMovies() {
        // Fetch popular movies
        rxMovieModel.getPopularMovies(pageNo: nil)
            .subscribe { [weak self] response in
                self?.observablePopularMovies.onNext(response.movies)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func loadPopularSeries() {
        // Fetch popular series
        rxMovieModel.getPopularSeries(pageNo: nil)
            .subscribe { [weak self] response in
                self?.observablePopularSeries.onNext(response.movies)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func loadMovieGenres() {
        // Fetch movie genres
        rxGenreModel.getGenres()
            .map { genres -> [GenreVO] in
                genres.map { $0.convertToVO() }
            }
            .subscribe { genreVOs in
                self.observableGenres.onNext(genreVOs)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func loadShowcaseMovies() {
        // Fetch show cases
        rxMovieModel.getShowcaseMovies(pageNo: nil)
            .subscribe { [weak self] response in
                self?.observableShowcaseMovieResponse.onNext(response)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func loadActors() {
        // Fetch actors
        rxActorModel.getActors(pageNo: 1)
            .subscribe { [weak self] response in
                self?.observableActorResponse.onNext(response)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    func rxLoadData() {
        loadSliderMovies()
        loadPopularMovies()
        loadPopularSeries()
        loadMovieGenres()
        loadShowcaseMovies()
        loadActors()
    }

}
