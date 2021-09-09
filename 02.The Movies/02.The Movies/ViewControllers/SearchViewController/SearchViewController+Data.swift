//
//  SearchViewController+Networking.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import Foundation

extension SearchViewController {
    
    func searchMovie(pageNo: Int = 1) {
        
//        movieModel.searchMovie(with: searchText, pageNo: pageNo) { [weak self] result in
//            do {
//                let response = try result.get()
//                self?.totalPages = response.totalPages ?? 1
//
//                if pageNo == 1 {
//                    self?.movies = response.movies
//                } else {
//                    self?.movies.append(contentsOf: response.movies)
//                }
//                self?.collectionView.reloadData()
//            } catch {
//                print("[Error while searching movie]", error)
//            }
//        }
        
        rxMovieModel.searchMovie(with: searchText, pageNo: pageNo)
            .subscribe { [weak self] response in
                self?.totalPages = response.totalPages ?? 1
                
                if pageNo == 1 {
                    self?.movies = response.movies
                } else {
                    self?.movies.append(contentsOf: response.movies)
                }
                self?.collectionView.reloadData()
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
}
