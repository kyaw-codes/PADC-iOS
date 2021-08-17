//
//  ListViewController+Delegates.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import UIKit

extension ListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if type == .casts {
            let width: CGFloat = (collectionView.frame.width - 20 - ((noOfCols - 1) * spacing)) / noOfCols
            let height: CGFloat = width + width * 0.5
            return .init(width: width, height: height)
        } else {
            let width: CGFloat = collectionView.frame.width - 20
            let height: CGFloat = (width * 9) / 16
            return .init(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type == .casts ? actors.count : movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if type == .casts {
            let item = actors[indexPath.row]
            let cell = collectionView.dequeueCell(ofType: BestActorsCollectionViewCell.self, for: indexPath, shouldRegister: true) { cell in
                cell.bestActor = item
            }
            return cell
        } else {
            let item = movies[indexPath.row]
            let cell = collectionView.dequeueCell(ofType: ShowCaseCollectionViewCell.self, for: indexPath, shouldRegister: true) { cell in
                cell.movie = item
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isLastRow = indexPath.row == (type == .casts
                                          ? actors.count - 1
                                          : movies.count - 1)
        
        if isLastRow && currentPage <= noOfPages {
            loadNextPageData(pageNo: currentPage + 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if type == .casts {
            let item = actors[indexPath.row]
            self.onActorCellTapped(actorId: item.id)
        } else {
            let vc = MovieDetailViewController.instantiate()
            vc.movieId = movies[indexPath.row].id ?? -1
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.frame.height / 2 {
            upButton.isHidden = false
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.upButton.transform = .identity
            }
        } else {
            if upButton.transform.isIdentity {
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.upButton.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                }
            }
        }
    }
}

// MARK: - ActorActionDelegate

extension ListViewController: ActorActionDelegate {
    func onFavouriteTapped(isFavourite: Bool) {
        // TODO: - Implement later
    }
    
}
