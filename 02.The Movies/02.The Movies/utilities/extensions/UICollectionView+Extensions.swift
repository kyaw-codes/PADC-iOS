//
//  UICollectionView+Extensions.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 30/01/2021.
//

import UIKit

extension UICollectionView {
    
    func registerCellWithNib<T: UICollectionViewCell>(_ cell: T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: nil), forCellWithReuseIdentifier: String(describing: T.self))
    }
}
