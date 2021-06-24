//
//  ViewController.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/01/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var moviesTableView: UITableView!
    
    private let movieService = MovieDbService.shared
    private var upcomingMovies: [Movie]?
    private var popularMovies: [Movie]?
    private var popularSeries: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.dataSource = self
        
        [MovieSliderTableViewCell.self, PopularMovieTableViewCell.self, CheckShowtimeTableViewCell.self, MovieWithGenreTableViewCell.self, ShowcaseTableViewCell.self, BestActorsTableViewCell.self].forEach {
            moviesTableView.register(
                UINib(nibName: String(describing: $0), bundle: nil), forCellReuseIdentifier: String(describing: $0))
        }
        
        loadNetworkRequests()
    }
    
}

// MARK: - Network Request

extension HomeViewController {
    
    public enum Sections: Int, CaseIterable {
        case movieSlider = 0
        case popularMovies = 1
        case popularSeries = 2
        case checkShowTime = 3
        case movieWithGenre = 4
        case showCase = 5
        case bestActors = 6
    }
    
    private func loadNetworkRequests() {
        
        // Fetch upcoming movies
        movieService.fetchMovies(with: "/movie/upcoming") { [weak self] result in
            do {
                self?.upcomingMovies = try result.get()
                self?.updateUI(at: .movieSlider)
            } catch {
                print("[Error: while fetching UpComingMovies]", error)
            }
        }

        // Fetch popular movies
        movieService.fetchMovies(with: "/movie/popular") { [weak self] result in
            do {
                self?.popularMovies = try result.get()
                self?.updateUI(at: .popularMovies)
            } catch {
                print("[Error: while fetching PopularMovies]", error)
            }
        }
        
        // Fetch popular series
        movieService.fetchMovies(with: "/tv/popular") { [weak self] result in
            do {
                self?.popularSeries = try result.get()
                self?.updateUI(at: .popularSeries)
            } catch {
                print("[Error: while fetching PopularSeries]", error)
            }
        }
    }
    
    private func updateUI(at section: Sections) {
        let indexSet = IndexSet(integer: section.rawValue)
        moviesTableView.reloadSections(indexSet, with: .automatic)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Sections.movieSlider.rawValue:
            let cell = dequeueTableViewCell(ofType: MovieSliderTableViewCell.self, with: tableView, for: indexPath)
            cell.delegate = self
            cell.movies = upcomingMovies
            return cell
        case Sections.popularMovies.rawValue:
            let cell = dequeueTableViewCell(ofType: PopularMovieTableViewCell.self, with: tableView, for: indexPath)
            cell.delegate = self
            cell.sectionTitle.text = "BEST POPULAR MOVIES"
            cell.movies = popularMovies
            return cell
        case Sections.popularSeries.rawValue:
            let cell = dequeueTableViewCell(ofType: PopularMovieTableViewCell.self, with: tableView, for: indexPath)
            cell.delegate = self
            cell.sectionTitle.text = "BEST POPULAR SERIES"
            cell.movies = popularSeries
            return cell
        case Sections.checkShowTime.rawValue:
            return dequeueTableViewCell(ofType: CheckShowtimeTableViewCell.self, with: tableView, for: indexPath)
        case Sections.movieWithGenre.rawValue:
            return dequeueTableViewCell(ofType: MovieWithGenreTableViewCell.self, with: tableView, for: indexPath)
        case Sections.showCase.rawValue:
            return dequeueTableViewCell(ofType: ShowcaseTableViewCell.self, with: tableView, for: indexPath)
        case Sections.bestActors.rawValue:
            return dequeueTableViewCell(ofType: BestActorsTableViewCell.self, with: tableView, for: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    fileprivate func dequeueTableViewCell<T: UITableViewCell>(ofType: T.Type, with tableView: UITableView, for indexPath: IndexPath, _ setupCell: ((T) -> Void) = {_ in}) -> T {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("ERROR: Fail to cast the given cell into \(T.self)")
        }
        setupCell(cell)
        return cell
    }
}

extension HomeViewController: MovieItemDelegate {

    func onItemTap() {
        // Navigate to detail view controller
        let detailVC = MovieDetailViewController.instantiate()
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.modalTransitionStyle = .flipHorizontal
        present(detailVC, animated: true, completion: nil)
    }

}

