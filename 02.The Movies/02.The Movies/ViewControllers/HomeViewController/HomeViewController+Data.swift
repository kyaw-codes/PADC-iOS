//
//  HomeViewController+Networking.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import Foundation
import RxDataSources

extension HomeViewController {
    
    // MARK: - Load data from model
    
    func rxLoadData() {
        loadSliderMovies()
        loadPopularMovies()
        loadPopularSeries()
        loadMovieGenres()
        loadShowcaseMovies()
        loadActors()
    }

    fileprivate func loadSliderMovies() {
        // Fetch slider movies
        rxMovieModel.getSliderMovies(pageNo: nil)
            .subscribe { [weak self] response in
                self?.observableSliderMovies.onNext(response.movies)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func loadPopularMovies() {
        // Fetch popular movies
        rxMovieModel.getPopularMovies(pageNo: nil)
            .subscribe { [weak self] response in
                self?.observablePopularMovies.onNext(response.movies)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func loadPopularSeries() {
        // Fetch popular series
        rxMovieModel.getPopularSeries(pageNo: nil)
            .subscribe { [weak self] response in
                self?.observablePopularSeries.onNext(response.movies)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func loadMovieGenres() {
        // Fetch movie genres
        rxGenreModel.getGenres()
            .map { genres -> [GenreVO] in
                genres.map { $0.convertToVO() }
            }
            .subscribe { genreVOs in
                self.observableGenres.onNext(genreVOs)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func loadShowcaseMovies() {
        // Fetch show cases
        rxMovieModel.getShowcaseMovies(pageNo: nil)
            .subscribe { [weak self] response in
                self?.observableShowcaseMovieResponse.onNext(response)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func loadActors() {
        // Fetch actors
        rxActorModel.getActors(pageNo: 1)
            .subscribe { [weak self] response in
                self?.observableActorResponse.onNext(response)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Init RxTableViewSectionedReloadDataSource
    
    func initRxDatasource() -> RxTableViewSectionedReloadDataSource<HomeSectionModel> {
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
                    self.observableShowcaseMovieResponse
                        .do { data in
//                            vc.observableNoOfPages.onNext(data?.totalPages ?? 1)
                            vc.observableNoOfPages = .just(data?.totalPages ?? 1)
                        }
                        .compactMap { $0?.movies }
                        .subscribe { data in
                            vc.observableMovieList.onNext(data)
                        } onError: { error in
                            print(error)
                        }
                        .disposed(by: self.disposeBag)
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
    
    private func dequeueTableViewCell<T: UITableViewCell>(ofType: T.Type, with tableView: UITableView, for indexPath: IndexPath, _ setupCell: ((T) -> Void) = {_ in}) -> T {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("ERROR: Fail to cast the given cell into \(T.self)")
        }
        setupCell(cell)
        return cell
    }
    
}
