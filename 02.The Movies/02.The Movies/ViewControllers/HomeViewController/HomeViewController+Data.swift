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
        movieModel.getSliderMovies(pageNo: nil) { [weak self] result in
            do {
                self?.sliderMovies = try result.get().movies
                self?.updateUI(at: .movieSlider)
            } catch {
                print("[Error: while fetching UpComingMovies]", error)
            }
        }

        // Fetch popular movies
        movieModel.getPopularMovies(pageNo: nil) { [weak self] result in
            do {
                self?.popularMovies = try result.get().movies
                self?.updateUI(at: .popularMovies)
            } catch {
                print("[Error: while fetching PopularMovies]", error)
            }
        }
        
        // Fetch popular series
        movieModel.getPopularSeries(pageNo: nil) { [weak self] result in
            do {
                self?.popularSeries = try result.get().movies
                self?.updateUI(at: .popularSeries)
            } catch {
                print("[Error: while fetching PopularSeries]", error)
            }
        }
        
        // Fetch movie genres
        genreModel.getGenres { [weak self] result in
            do {
                let genres = try result.get()
                self?.movieGenres = genres.map { $0.convertToVO() }
                self?.updateUI(at: .movieWithGenre)
            } catch {
                print("[Error: while fetching MovieWithGenres]", error)
            }
        }
        
        // Fetch show cases
        movieModel.getShowcaseMovies(pageNo: nil) { [weak self] result in
            do {
                self?.showcaseMovieResponse = try result.get()
                self?.showcaseMovies = self?.showcaseMovieResponse?.movies
                self?.updateUI(at: .showCase)
            } catch {
                print("[Error: while fetching TopRated]", error)
            }
        }
        
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
