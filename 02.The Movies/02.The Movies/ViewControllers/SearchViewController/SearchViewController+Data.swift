//
//  SearchViewController+Networking.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import Foundation

extension SearchViewController {
    
    func rxSearchMovie(keyword: String, page: Int) {
        rxMovieModel.searchMovie(with: keyword, pageNo: page)
            .do { [weak self] items in
                self?.totalPages = items.totalPages ?? 1
            }
            .compactMap { $0.movies }
            .subscribe { movies in
                if self.currentPage == 1 {
                    self.searchResultItems.onNext(movies)
                } else {
                    self.searchResultItems.onNext(try! self.searchResultItems.value() + movies)
                }
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
}
