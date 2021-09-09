//
//  HomeViewController+Networking.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import Foundation

extension HomeViewController {
    
    func loadData() {
        
        // Fetch slider movies
        rxMovieModel.getSliderMovies(pageNo: nil)
            .subscribe { [weak self] response in
                self?.sliderMovies = response.movies
                self?.updateUI(at: .movieSlider)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)

        // Fetch popular movies
        rxMovieModel.getPopularMovies(pageNo: nil)
            .subscribe { [weak self] response in
                self?.popularMovies = response.movies
                self?.updateUI(at: .popularMovies)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        // Fetch popular series
        rxMovieModel.getPopularSeries(pageNo: nil)
            .subscribe { [weak self] response in
                self?.popularSeries = response.movies
                self?.updateUI(at: .popularSeries)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        // Fetch movie genres
        rxGenreModel.getGenres()
            .subscribe { [weak self] genres in
                self?.movieGenres = genres.map { $0.convertToVO() }
                self?.updateUI(at: .movieWithGenre)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        // Fetch show cases
        rxMovieModel.getShowcaseMovies(pageNo: nil)
            .subscribe { [weak self] response in
                self?.showcaseMovies = response.movies
                self?.updateUI(at: .showCase)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
        
        // Fetch actors
        actorModel.getActors(pageNo: nil) { [weak self] result in
            do {
                let actorResponse = try result.get()
                actorResponse.actors?.forEach {
                    self?.bestActors.append($0)
                }
                self?.actorResponse = actorResponse
                self?.updateUI(at: .bestActors)
            } catch {
                print("[Error: while fetching Actors]", error)
            }
        }
    }
    
}
