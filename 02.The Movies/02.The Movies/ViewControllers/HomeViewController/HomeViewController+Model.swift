//
//  File.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 11/09/2021.
//

import RxDataSources

enum HomeSectionModel : SectionModelType {
    
    case SliderMovies(items: [SectionItem])
    case PopularMovies(items: [SectionItem])
    case PopularSeries(items: [SectionItem])
    case MovieShowTime(item: SectionItem)
    case MovieWithGenres(items: [SectionItem])
    case ShowcaseMovies(items: [SectionItem])
    case BestActors(items: [SectionItem])

    typealias Item = SectionItem

    var items: [SectionItem] {
        switch self {
        case .SliderMovies(let items):
            return items
        case .PopularMovies(let items):
            return items
        case .PopularSeries(let items):
            return items
        case .MovieShowTime(let item):
            return [item]
        case .MovieWithGenres(let items):
            return items
        case .ShowcaseMovies(let items):
            return items
        case .BestActors(let items):
            return items
        }
    }
    
    init(original: HomeSectionModel, items: [SectionItem]) {
        switch original {
        case .SliderMovies(let items):
            self = .SliderMovies(items: items)
        case .PopularMovies(let items):
            self = .PopularMovies(items: items)
        case .PopularSeries(let items):
            self = .PopularSeries(items: items)
        case .MovieShowTime(let item):
            self = .MovieShowTime(item: item)
        case .MovieWithGenres(let items):
            self = .MovieWithGenres(items: items)
        case .ShowcaseMovies(let items):
            self = .ShowcaseMovies(items: items)
        case .BestActors(let items):
            self = .BestActors(items: items)
        }
    }

    enum SectionItem {
        case SliderMoviesSectionItem(items: [Movie])
        case PopularMoviesSectionItem(items: [Movie])
        case PopularSeriesSectionItem(items: [Movie])
        case MovieShowTimeSectionItem(item: String)
        case MovieWithGenresSectionItem(items: [Movie])
        case ShowcaseMoviesSectionItem(items: [GenreVO])
        case BestActorsSectionItem(items: [Actor])
    }
}
