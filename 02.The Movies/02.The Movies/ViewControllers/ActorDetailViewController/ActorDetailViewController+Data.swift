//
//  ActorDetailViewController+Networking.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import UIKit

extension ActorDetailViewController {
    
    func loadDetailData() {
//        actorModel.getActorDetail(actorId: id) { [weak self] result in
//            do {
//                self?.actorDetail = try result.get()
//                self?.navigationItem.title = self?.actorDetail?.name
//            } catch {
//                print(error)
//            }
//        }
        
        rxActorModel.getActorDetail(actorId: id)
            .subscribe { [weak self] response in
                self?.actorDetail = response
                self?.navigationItem.title = self?.actorDetail?.name
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
        
//        actorModel.getActorCredits(actorId: id) { [weak self] result in
//            do {
//                let result = try result.get()
//                result.movies?.forEach { self?.movies.append($0.convertToMovie()) }
//                self?.moviesCollectionView.reloadData()
//            } catch {
//                print(error)
//            }
//        }
        
        rxActorModel.getActorCredits(actorId: id)
            .compactMap { $0.movies }
            .subscribe { [weak self] movies in
                movies.forEach {
                    self?.movies.append($0.convertToMovie())
                }
                self?.moviesCollectionView.reloadData()
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
}
