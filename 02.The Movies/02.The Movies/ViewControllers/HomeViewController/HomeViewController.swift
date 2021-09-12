//
//  ViewController.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/01/2021.
//

import UIKit
import RxSwift
import RxDataSources

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    // MARK: - Properties
    
    var observableSliderMovies: BehaviorSubject<[Movie]> = BehaviorSubject(value: [])
    var observablePopularMovies: BehaviorSubject<[Movie]> = BehaviorSubject(value: [])
    var observablePopularSeries: BehaviorSubject<[Movie]> = BehaviorSubject(value: [])
    var observableGenres: BehaviorSubject<[GenreVO]> = BehaviorSubject(value: [])
    var observableShowcaseMovieResponse: BehaviorSubject<MovieResponse?> = BehaviorSubject(value: nil)
    var observableActorResponse: BehaviorSubject<ActorResponse?> = BehaviorSubject(value: nil)
    
    var datasource: RxTableViewSectionedReloadDataSource<HomeSectionModel>!
    
    let rxMovieModel: RxMoviesModel = RxMoviesModelImpl.shared
    let rxGenreModel: RxGenreModel = RxGenreModelImpl.shared
    let rxActorModel: RxActorModel = RxActorModelImpl.shared
    
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [MovieSliderTableViewCell.self,
         PopularMovieTableViewCell.self,
         CheckShowtimeTableViewCell.self,
         MovieWithGenreTableViewCell.self,
         ShowcaseTableViewCell.self,
         BestActorsTableViewCell.self
        ].forEach {
            moviesTableView.register(
                UINib(nibName: String(describing: $0), bundle: nil), forCellReuseIdentifier: String(describing: $0))
        }
        
        rxLoadData()
        
        self.datasource = initRxDatasource()
        bindModelsWithDatasource()
    }
    
    // MARK: - Target/Action Handlers
    
    @IBAction private func onSearchButtonTapped(_ sender: Any) {
        guard let navVC = storyboard?.instantiateViewController(identifier: "SearchNavigationController") else {
            fatalError("Cannot find SearchNavigationController")
        }
        present(navVC, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    fileprivate func bindModelsWithDatasource() {
        Observable.combineLatest(
            observableSliderMovies,
            observablePopularMovies,
            observablePopularSeries,
            observableShowcaseMovieResponse.flatMap { Observable.just($0?.movies ?? [Movie]()) },
            observableActorResponse.flatMap { Observable.just($0?.actors ?? [Actor]()) }
        )
        .flatMapLatest { (sliderMovies, popularMovies, popularSeries, showcaseMovies, actors) -> Observable<[HomeSectionModel]> in
            var items = [HomeSectionModel]()
            
            if !sliderMovies.isEmpty {
                items.append(.SliderMovies(items: [.SliderMoviesSectionItem(items: sliderMovies)]))
            }
            
            if !popularMovies.isEmpty {
                items.append(.PopularMovies(items: [.PopularMoviesSectionItem(items: popularMovies)]))
            }
            
            if !popularSeries.isEmpty {
                items.append(.PopularSeries(items: [.PopularSeriesSectionItem(items: popularSeries)]))
            }
            
            items.append(.MovieShowTime(item: .MovieShowTimeSectionItem(item: "")))
            
            items.append(.MovieWithGenres(items: [.MovieWithGenresSectionItem(items: popularMovies)]))
            
            if !showcaseMovies.isEmpty {
                items.append(.ShowcaseMovies(items: [.ShowcaseMoviesSectionItem(items: showcaseMovies)]))
            }
            
            if !actors.isEmpty {
                items.append(.BestActors(items: [.BestActorsSectionItem(items: actors)]))
            }
            
            return .just(items)
        }
        .bind(to: moviesTableView.rx.items(dataSource: datasource))
        .disposed(by: disposeBag)
    }
    
}
