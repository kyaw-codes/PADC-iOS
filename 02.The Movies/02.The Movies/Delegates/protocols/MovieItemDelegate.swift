//
//  MovieItemDelegate.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 04/05/2021.
//

import Foundation

protocol MovieItemDelegate {
    
    func onItemTap(movieId: Int?, type: MovieDbService.ContentType)
}
