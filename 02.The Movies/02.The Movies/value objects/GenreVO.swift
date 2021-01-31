//
//  GenreVO.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/01/2021.
//

import Foundation

class GenreVO {
    
    var genreName: String
    var isSelected: Bool = false
    
    init(genreName: String, isSelected: Bool) {
        self.genreName = genreName
        self.isSelected = isSelected
    }
    
}
