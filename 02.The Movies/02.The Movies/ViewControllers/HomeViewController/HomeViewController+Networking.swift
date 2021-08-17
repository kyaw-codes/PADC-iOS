//
//  HomeViewController+Networking.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import Foundation

extension HomeViewController {
    
    func loadNetworkRequests() {
        
        // Fetch upcoming movies
        networkAgent.fetchMovies(withEndpoint: .upComingMovies) { [weak self] result in
            do {
                self?.upcomingMovies = try result.get().movies
                self?.updateUI(at: .movieSlider)
            } catch {
                print("[Error: while fetching UpComingMovies]", error)
            }
        }

        // Fetch popular movies
        networkAgent.fetchMovies(withEndpoint: .popularMovies) { [weak self] result in
            do {
                self?.popularMovies = try result.get().movies
                self?.updateUI(at: .popularMovies)
            } catch {
                print("[Error: while fetching PopularMovies]", error)
            }
        }
        
        // Fetch popular series
        networkAgent.fetchMovies(withEndpoint: .popularSeries) { [weak self] result in
            do {
                self?.popularSeries = try result.get().movies
                self?.updateUI(at: .popularSeries)
            } catch {
                print("[Error: while fetching PopularSeries]", error)
            }
        }
        
        // Fetch movie genres
        networkAgent.fetchGenres(withEndpoint: .genres) { [weak self] result in
            do {
                let genres = try result.get()
                self?.movieGenres = genres.map { $0.convertToVO() }
                self?.updateUI(at: .movieWithGenre)
            } catch {
                print("[Error: while fetching MovieWithGenres]", error)
            }
        }
        
        // Fetch show cases
        networkAgent.fetchShowcaseMovies(withEndpoint: .showcaseMovies) { [weak self] result in
            do {
                self?.showcaseMovieResponse = try result.get()
                self?.showcaseMovies = self?.showcaseMovieResponse?.movies
                self?.updateUI(at: .showCase)
            } catch {
                print("[Error: while fetching TopRated]", error)
            }
        }
        
        // Fetch actors
        networkAgent.fetchActors(withEndpoint: .popularActors) { [weak self] result in
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
