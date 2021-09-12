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
    
    //    var sliderMovies: [Movie]?
    //    var popularMovies: [Movie]?
    //    var popularSeries: [Movie]?
    //    var movieGenres: [GenreVO]?
    //    var showcaseMovies: [Movie]?
    //    var bestActors: [Actor] = []
    //    var showcaseMovieResponse: MovieResponse?
    //    var actorResponse: ActorResponse?
    
    var observableSliderMovies: BehaviorSubject<[Movie]> = BehaviorSubject(value: [])
    var observablePopularMovies: BehaviorSubject<[Movie]> = BehaviorSubject(value: [])
    var observablePopularSeries: BehaviorSubject<[Movie]> = BehaviorSubject(value: [])
    var observableGenres: BehaviorSubject<[GenreVO]> = BehaviorSubject(value: [])
    var observableShowcaseMovieResponse: BehaviorSubject<MovieResponse?> = BehaviorSubject(value: nil)
    var observableActorResponse: BehaviorSubject<ActorResponse?> = BehaviorSubject(value: nil)
    
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
        
        let dataSource = initDatasource()
        
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
        .bind(to: moviesTableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }
    
    // MARK: - Target/Action Handlers
    
    @IBAction private func onSearchButtonTapped(_ sender: Any) {
        guard let navVC = storyboard?.instantiateViewController(identifier: "SearchNavigationController") else {
            fatalError("Cannot find SearchNavigationController")
        }
        present(navVC, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func dequeueTableViewCell<T: UITableViewCell>(ofType: T.Type, with tableView: UITableView, for indexPath: IndexPath, _ setupCell: ((T) -> Void) = {_ in}) -> T {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("ERROR: Fail to cast the given cell into \(T.self)")
        }
        setupCell(cell)
        return cell
    }
    
    func initDatasource() -> RxTableViewSectionedReloadDataSource<HomeSectionModel> {
        RxTableViewSectionedReloadDataSource<HomeSectionModel> { dataSource, tableView, indexPath, item in
            switch item {
            case .SliderMoviesSectionItem(let items):
                let cell = self.dequeueTableViewCell(ofType: MovieSliderTableViewCell.self, with: tableView, for: indexPath)
                cell.delegate = self
                cell.movies = items
                return cell
            case .PopularMoviesSectionItem(let items):
                let cell = self.dequeueTableViewCell(ofType: PopularMovieTableViewCell.self, with: tableView, for: indexPath)
                cell.delegate = self
                cell.sectionTitle.text = "BEST POPULAR MOVIES"
                cell.movies = items
                return cell
            case .PopularSeriesSectionItem(let items):
                let cell = self.dequeueTableViewCell(ofType: PopularMovieTableViewCell.self, with: tableView, for: indexPath)
                cell.delegate = self
                cell.sectionTitle.text = "BEST POPULAR SERIES"
                cell.movies = items
                return cell
            case .MovieShowTimeSectionItem(_):
                return self.dequeueTableViewCell(ofType: CheckShowtimeTableViewCell.self, with: tableView, for: indexPath)
            case .MovieWithGenresSectionItem(let items):
                let cell = self.dequeueTableViewCell(ofType: MovieWithGenreTableViewCell.self, with: tableView, for: indexPath)
                cell.movies = items
                cell.delegate = self
                cell.genreList = try! self.observableGenres.value()
                return cell
            case .ShowcaseMoviesSectionItem(let items):
                let cell = self.dequeueTableViewCell(ofType: ShowcaseTableViewCell.self, with: tableView, for: indexPath)
                cell.movies = items
                cell.delegate = self
                cell.onMoreShowcasesTapped = {
                    let vc = ListViewController.instantiate()
                    vc.type = .movies
                    vc.movieResponse = try! self.observableShowcaseMovieResponse.value()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                return cell
            case .BestActorsSectionItem(let items):
                let cell = self.dequeueTableViewCell(ofType: BestActorsTableViewCell.self, with: tableView, for: indexPath)
                cell.actors = items
                cell.onViewMoreTapped = { [weak self] in
                    let vc = ListViewController.instantiate()
                    vc.actorResponse = try! self?.observableActorResponse.value()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                cell.delegate = self
                return cell
            }
        }
    }
}
