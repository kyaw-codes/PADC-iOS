//
//  GenreVO.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/01/2021.
//

import Foundation

class GenreVO {
    
    var id: Int
    var genreName: String
    var isSelected: Bool = false
    
    init(id: Int = 0, genreName: String, isSelected: Bool) {
        self.id = id
        self.genreName = genreName
        self.isSelected = isSelected
    }
    
}
