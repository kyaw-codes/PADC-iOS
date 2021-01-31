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
        
        [MovieSliderTableViewCell.self, PopularMovieTableViewCell.self, CheckShowtimeTableViewCell.self, MovieWithGenreTableViewCell.self, ShowcaseTableViewCell.self].forEach {
            moviesTableView.register(
                UINib(nibName: String(describing: $0), bundle: nil), forCellReuseIdentifier: String(describing: $0))
        }
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return dequeueTableViewCell(ofType: MovieSliderTableViewCell.self, with: tableView, for: indexPath)
        case 1:
            return dequeueTableViewCell(ofType: PopularMovieTableViewCell.self, with: tableView, for: indexPath)
        case 2:
            return dequeueTableViewCell(ofType: CheckShowtimeTableViewCell.self, with: tableView, for: indexPath)
        case 3:
            return dequeueTableViewCell(ofType: MovieWithGenreTableViewCell.self, with: tableView, for: indexPath)
        case 4:
            return dequeueTableViewCell(ofType: ShowcaseTableViewCell.self, with: tableView, for: indexPath)
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

