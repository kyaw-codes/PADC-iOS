//
//  ListViewController+Networking.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import UIKit

extension ListViewController {
    
    func fetchNextPage(pageNo: Int) {
        if type == .casts {
            fetchActors(pageNo: pageNo)
        } else {
            fetchMovies(pageNo: pageNo)
        }
    }
    
    private func fetchActors(pageNo: Int) {
        networkAgent.fetchActors(withEndpoint: .allActors(pageNo: pageNo)) { [weak self] result in
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
    
    private func fetchMovies(pageNo: Int) {
        networkAgent.fetchMovies(withEndpoint: .showcaseMovies, pageNo: pageNo) { [weak self] result in
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
