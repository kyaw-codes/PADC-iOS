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
        movieService.fetchActors(with: "/person/popular", pageNo: pageNo) { [weak self] result in
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
        movieService.fetchMovies(with: "/movie/top_rated", pageNo: pageNo) { [weak self] result in
            do {
                let movies = try result.get()
                movies.forEach {
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
