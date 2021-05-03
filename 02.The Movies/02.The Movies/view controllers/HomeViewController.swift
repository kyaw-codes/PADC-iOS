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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.dataSource = self
        
        [MovieSliderTableViewCell.self, PopularMovieTableViewCell.self, CheckShowtimeTableViewCell.self, MovieWithGenreTableViewCell.self, ShowcaseTableViewCell.self, BestActorsTableViewCell.self].forEach {
            moviesTableView.register(
                UINib(nibName: String(describing: $0), bundle: nil), forCellReuseIdentifier: String(describing: $0))
        }
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = dequeueTableViewCell(ofType: MovieSliderTableViewCell.self, with: tableView, for: indexPath)
            cell.delegate = self
            return cell
        case 1:
            let cell = dequeueTableViewCell(ofType: PopularMovieTableViewCell.self, with: tableView, for: indexPath)
            cell.delegate = self
            return cell
        case 2:
            return dequeueTableViewCell(ofType: CheckShowtimeTableViewCell.self, with: tableView, for: indexPath)
        case 3:
            return dequeueTableViewCell(ofType: MovieWithGenreTableViewCell.self, with: tableView, for: indexPath)
        case 4:
            return dequeueTableViewCell(ofType: ShowcaseTableViewCell.self, with: tableView, for: indexPath)
        case 5:
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

