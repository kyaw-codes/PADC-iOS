//
//  MovieDetailViewController+Networking.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import UIKit

extension MovieDetailViewController {
    
    func loadData() {
//        movieModel.getMovieDetail(movieId: movieId, contentType: self.contentType) { [weak self] result in
//            do {
//                let movieDetail = try result.get()
//                self?.movieDetail = movieDetail
//                self?.bindData(with: movieDetail)
//                self?.navigationItem.title = movieDetail.name ?? movieDetail.title
//            } catch {
//                print(error)
//            }
//        }
        
        rxMovieModel.getMovieDetail(movieId: movieId, contentType: self.contentType)
            .compactMap { $0 }
            .subscribe { [weak self] response in
                self?.movieDetail = response
                self?.bindData(with: response)
                self?.navigationItem.title = response.name ?? response.title
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)

        fetchMovieCredits()
        fetchSimilarMovies()
    }
    
    func downloadVideoAndPlay() {
//        movieModel.getTrailer(movieId: movieId, contentType: self.contentType) { [weak self] result in
//            do {
//                let trailer = try result.get()
//                let playerVC = YoutubePlayerViewController.instantiate()
//                playerVC.keyPath = trailer.keyPath
//                self?.present(playerVC, animated: true, completion: nil)
//            } catch {
//               print(error)
//            }
//        }
        rxMovieModel.getTrailer(movieId: movieId, contentType: self.contentType)
            .subscribe { [weak self] response in
                let playerVC = YoutubePlayerViewController.instantiate()
                playerVC.keyPath = response.keyPath
                self?.present(playerVC, animated: true, completion: nil)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    private func fetchMovieCredits() {
//        movieModel.getMovieCredits(ofMovieId: movieId, contentType: self.contentType) { [weak self] result in
//            do {
//                self?.actors = try result.get()
//                self?.actorsCollectionView.reloadData()
//            } catch {
//                print(error)
//            }
//        }
        
        rxMovieModel.getMovieCredits(ofMovieId: movieId, contentType: self.contentType)
            .subscribe { [weak self] response in
                self?.actors = response
                self?.actorsCollectionView.reloadData()
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    private func fetchSimilarMovies() {
//        movieModel.getSimilarMovies(ofMovieId: movieId, contentType: self.contentType) { [weak self] result in
//            do {
//                self?.similarMovies = try result.get().movies
//                self?.similarMoviesCollectionView.reloadData()
//            } catch {
//                print(error)
//            }
//        }
        
        rxMovieModel.getSimilarMovies(ofMovieId: movieId, contentType: self.contentType)
            .subscribe { [weak self] response in
                self?.similarMovies = response.movies
                self?.similarMoviesCollectionView.reloadData()
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
}
