//
//  ListViewController+Networking.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import UIKit

extension ListViewController {
    
    func loadNextPageData(pageNo: Int) {
        if type == .casts {
            loadActors(pageNo: pageNo)
        } else {
            loadMovies(pageNo: pageNo)
        }
    }
    
    private func loadActors(pageNo: Int) {
        actorModel.getActors(pageNo: pageNo) { [weak self] result in
            do {
                let actorResponse = try result.get()
                actorResponse.actors?.forEach {
                    self?.actors.append($0)
                }
                self?.collectionView.reloadData()
                self?.currentPage += 1
            } catch {
                print("[Error: while fetching Actors]", error)
            }
        }
    }
    
    private func loadMovies(pageNo: Int) {
        movieModel.getShowcaseMovies(pageNo: pageNo) { [weak self] result in
            do {
                let movieResponse = try result.get()
                movieResponse.movies.forEach {
                    self?.movies.append($0)
                }
                self?.collectionView.reloadData()
                self?.currentPage += 1
            } catch {
                print("[Error: while fetching top rated movies]", error)
            }
        }
    }
}
