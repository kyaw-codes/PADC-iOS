//
//  MovieDetailViewController+Networking.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import UIKit

extension MovieDetailViewController {
    
    func fetchContents() {
        networkAgent.fetchMovieDetail(movieId: movieId, contentType: self.contentType) { [weak self] result in
            do {
                let movieDetail = try result.get()
                self?.movieDetail = movieDetail
                self?.bindData(with: movieDetail)
                self?.navigationItem.title = movieDetail.name ?? movieDetail.title
            } catch {
                print(error)
            }
        }
        
        fetchMovieCredits()
        fetchSimilarMovies()
    }
    
    func downloadVideoAndPlay() {
        networkAgent.fetchTrailer(movieId: movieId, contentType: self.contentType) { [weak self] result in
            do {
                let trailer = try result.get()
                let playerVC = YoutubePlayerViewController.instantiate()
                playerVC.keyPath = trailer.keyPath
                self?.present(playerVC, animated: true, completion: nil)
            } catch {
                
            }
        }
    }
    
    private func fetchMovieCredits() {
        networkAgent.fetchActors(ofMovieId: movieId, contentType: self.contentType) { [weak self] result in
            do {
                self?.actors = try result.get()
                self?.actorsCollectionView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private func fetchSimilarMovies() {
        networkAgent.fetchSimilarMovies(ofMovieId: movieId, contentType: self.contentType) { [weak self] result in
            do {
                self?.similarMovies = try result.get()
                self?.similarMoviesCollectionView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
}