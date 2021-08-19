//
//  HomeViewController+Delegates.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import UIKit

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
            cell.movies = sliderMovies
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
            let cell = dequeueTableViewCell(ofType: MovieWithGenreTableViewCell.self, with: tableView, for: indexPath)
            cell.movies = popularMovies
            cell.delegate = self
            cell.genreList = movieGenres
            return cell
        case Sections.showCase.rawValue:
            let cell = dequeueTableViewCell(ofType: ShowcaseTableViewCell.self, with: tableView, for: indexPath)
            cell.movies = showcaseMovies
            cell.delegate = self
            cell.onMoreShowcasesTapped = { [weak self] in
                let vc = ListViewController.instantiate()
                vc.type = .movies
                vc.movieResponse = self?.showcaseMovieResponse
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        case Sections.bestActors.rawValue:
            let cell = dequeueTableViewCell(ofType: BestActorsTableViewCell.self, with: tableView, for: indexPath)
            cell.actors = bestActors
            cell.onViewMoreTapped = { [weak self] in
                let vc = ListViewController.instantiate()
                vc.actorResponse = self?.actorResponse
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

// MARK: - Custom Delegates

extension HomeViewController: MovieItemDelegate, ActorActionDelegate {

    func onItemTap(movieId: Int?, type: MovieFetchType) {
        // Navigate to detail view controller
        let detailVC = MovieDetailViewController.instantiate()
        detailVC.movieId = movieId ?? -1
        detailVC.contentType = type
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func onFavouriteTapped(isFavourite: Bool) {
        // TODO: - Do something
    }

}
