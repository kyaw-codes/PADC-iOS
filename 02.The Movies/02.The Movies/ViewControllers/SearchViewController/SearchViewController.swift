//
//  SearchViewController.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 09/07/2021.
//

import UIKit
import RxSwift

class SearchViewController: UIViewController, Storyboarded {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var upButton: UIButton!
    
    // MARK:  - Properties
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var movies: [Movie] = []
    var currentPage = 1
    var totalPages = 1
    var searchText = ""
    var noOfCols: CGFloat = 3
    var spacing: CGFloat = 10
    let movieModel: MoviesModel = MoviesModelImpl.shared
    let rxMovieModel: RxMoviesModel = RxMoviesModelImpl.shared
    
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupSearchBar()
        setupUpButton()
    }
    
    // MARK: - Target/Action Handler
    
    @IBAction private func onUpButtonTapped(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
}

