//
//  ActorsDelegate.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 05/02/2021.
//

import Foundation
import UIKit

protocol ActorActionDelegate {
    
    func onFavouriteTap(isFavourite: Bool)
    
    func onActorCellTap(actorId id: Int)
}

extension ActorActionDelegate where Self: UIViewController {
    
    func onActorCellTap(actorId id: Int) {
        let vc = ActorDetailViewController.instantiate()
        vc.id = id
        (self as UIViewController).present(vc, animated: true, completion: nil)
    }
}
