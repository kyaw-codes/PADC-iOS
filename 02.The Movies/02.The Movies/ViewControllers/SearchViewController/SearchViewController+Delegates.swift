//
//  SearchViewController+Delegates.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import UIKit

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueCell(ofType: PopularMovieCollectionViewCell.self, for: indexPath, shouldRegister: true) { cell in
            cell.movie = movies[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20 - ((noOfCols - 1) * spacing)) / noOfCols
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isLastRow = indexPath.row == movies.count - 1
        
        if isLastRow && currentPage <= totalPages {
            currentPage += 1
            searchMovie(pageNo: currentPage)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = movies[indexPath.item]
        let vc = MovieDetailViewController.instantiate()
        vc.movieId = item.id ?? -1
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            currentPage = 1
            searchText = text
            searchMovie()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movies = []
        collectionView.reloadData()
    }
    
}
