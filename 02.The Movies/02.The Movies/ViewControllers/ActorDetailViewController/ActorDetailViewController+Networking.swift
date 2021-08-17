//
//  ActorDetailViewController+Networking.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import UIKit

extension ActorDetailViewController {
    
    func fetchDetial() {
        networkAgent.fetchActorDetail(actorId: id) { [weak self] result in
            do {
                self?.actorDetail = try result.get()
                self?.navigationItem.title = self?.actorDetail?.name
            } catch {
                print(error)
            }
        }
        
        networkAgent.fetchMoviesRelatedTo(actorId: id) { [weak self] result in
            do {
                let result = try result.get()
                result.movies?.forEach { self?.movies.append($0.convertToMovie()) }
                self?.moviesCollectionView.reloadData()
            } catch {
                print(error)
            }
        }
    }
}
