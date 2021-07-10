//
//  MovieDetailViewController+Delegates.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import UIKit

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == companiesCollectionView {
            return companies?.count ?? 0
        } else if collectionView == badgeCollectionView {
            return movieDetail?.genres?.count ?? 0
        } else if collectionView == actorsCollectionView {
            return actors?.count ?? 0
        } else {
            return similarMovies?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == companiesCollectionView {
            let cell = collectionView.dequeueCell(ofType: CompanyCollectionViewCell.self, for: indexPath, shouldRegister: true)
            if let company = companies?[indexPath.row] {
                cell.company = company
            }
            return cell
        } else if collectionView == badgeCollectionView {
            let genre = movieDetail?.genres?[indexPath.row]
            let cell = collectionView.dequeueCell(ofType: GenreBadgeCollectionViewCell.self, for: indexPath, shouldRegister: true) { cell in
                cell.genre = genre
            }
            return cell
        } else if collectionView == actorsCollectionView {
            let cell = collectionView.dequeueCell(ofType: BestActorsCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.actorActionDelegate = self
            cell.bestActor = actors?[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueCell(ofType: PopularMovieCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.movie = similarMovies?[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == companiesCollectionView {
            let width = 100
            return .init(width: width, height: width)
        } else if collectionView == badgeCollectionView {
            let text = movieDetail?.genres?[indexPath.row].name ?? ""
            let textWidth = text.getWidth(of: UIFont(name: "Geeza Pro Regular", size: 15) ?? UIFont.systemFont(ofSize: 15))
            return .init(width: textWidth + 26, height: collectionView.frame.height)
        } else if collectionView == actorsCollectionView {
            let width = collectionView.frame.width * 0.35
            let height = width + width * 0.5
            return .init(width: width, height: height)
        } else {
            return .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == similarMoviesCollectionView {
            // Navigate to detail view controller
            let detailVC = MovieDetailViewController.instantiate()
            detailVC.movieId = similarMovies?[indexPath.row].id ?? -1
            detailVC.contentType = self.contentType
            navigationController?.pushViewController(detailVC, animated: true)
        } else if collectionView == actorsCollectionView {
            self.onActorCellTapped(actorId: actors?[indexPath.row].id ?? -1)
        }
    }
}

// MARK: - Custom Delegates
extension MovieDetailViewController : ActorActionDelegate {
    
    func onFavouriteTapped(isFavourite: Bool) {
        
    }
}
