//
//  ViewController.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/01/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    // MARK: - Properties
    
    let networkAgent = NetworkAgentImpl.shared
    var upcomingMovies: [Movie]?
    var popularMovies: [Movie]?
    var popularSeries: [Movie]?
    var movieGenres: [GenreVO]?
    var showcaseMovies: [Movie]?
    var bestActors: [Actor] = []
    var showcaseMovieResponse: MovieResponse?
    var actorResponse: ActorResponse?
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.dataSource = self
        
        [MovieSliderTableViewCell.self, PopularMovieTableViewCell.self, CheckShowtimeTableViewCell.self, MovieWithGenreTableViewCell.self, ShowcaseTableViewCell.self, BestActorsTableViewCell.self].forEach {
            moviesTableView.register(
                UINib(nibName: String(describing: $0), bundle: nil), forCellReuseIdentifier: String(describing: $0))
        }
        
        loadNetworkRequests()
    }
    
    // MARK: - Target/Action Handlers
    
    @IBAction private func onSearchButtonTapped(_ sender: Any) {
        guard let navVC = storyboard?.instantiateViewController(identifier: "SearchNavigationController") else {
            fatalError("Cannot find SearchNavigationController")
        }
        present(navVC, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    public enum Sections: Int, CaseIterable {
        case movieSlider = 0
        case popularMovies = 1
        case popularSeries = 2
        case checkShowTime = 3
        case movieWithGenre = 4
        case showCase = 5
        case bestActors = 6
    }
    
    func dequeueTableViewCell<T: UITableViewCell>(ofType: T.Type, with tableView: UITableView, for indexPath: IndexPath, _ setupCell: ((T) -> Void) = {_ in}) -> T {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("ERROR: Fail to cast the given cell into \(T.self)")
        }
        setupCell(cell)
        return cell
    }
    
    func updateUI(at section: Sections) {
        let indexSet = IndexSet(integer: section.rawValue)
        moviesTableView.reloadSections(indexSet, with: .automatic)
    }
}
