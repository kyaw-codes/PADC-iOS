//
//  ActorDetailViewController+Delegates.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import UIKit

extension ActorDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: PopularMovieCollectionViewCell.self, for: indexPath, shouldRegister: true) { [weak self] cell in
            
            cell.movie = self?.movies[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        self.onItemTap(
            movieId: movie.id,
            type: (movie.mediaType ?? "movie") == "tv"
                ? .tv
                : .movie
        )
    }
}

// MARK: - MovieItemDelegate

extension ActorDetailViewController: MovieItemDelegate {
    
    func onItemTap(movieId: Int?, type: MovieFetchType) {
        let vc = MovieDetailViewController.instantiate()
        vc.movieId = movieId ?? -1
        vc.contentType = type
        navigationController?.pushViewController(vc, animated: true)
    }
}
