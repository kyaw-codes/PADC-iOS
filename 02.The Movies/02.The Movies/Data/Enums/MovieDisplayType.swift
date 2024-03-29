//
//  MovieContentType.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 17/08/2021.
//

import RealmSwift

enum MovieDisplayType: String, CaseIterable, PersistableEnum {
    case sliderMovies = "Slider Movies"
    case popularMovies = "Popular Movies"
    case popularSeries = "Popular Series"
    case showcaseMovies = "Showcase Movies"
    case similarMoves = "Similar Movies"
    case movieWithGenres = "Actor Movies"
    case others = "Others"
}
