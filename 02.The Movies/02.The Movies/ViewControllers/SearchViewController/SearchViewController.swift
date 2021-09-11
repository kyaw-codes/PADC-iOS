//
//  SearchViewController.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 09/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController, Storyboarded {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var upButton: UIButton!
    
    // MARK:  - Properties
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchResultItems: BehaviorSubject<[Movie]> = BehaviorSubject(value: [])
    
    var currentPage = 1
    var totalPages = 1
    var noOfCols: CGFloat = 3
    var spacing: CGFloat = 10
    let rxMovieModel: RxMoviesModel = RxMoviesModelImpl.shared
    
    let disposeBag = DisposeBag()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        collectionView.delegate = self
        collectionView.register(UINib(nibName: String(describing: PopularMovieCollectionViewCell.self), bundle: .main), forCellWithReuseIdentifier: String(describing: PopularMovieCollectionViewCell.self))
        
        setupSearchBar()
        setupUpButton()
        
        initObservers()
    }
    
    // MARK: - Target/Action Handler
    
    @IBAction private func onUpButtonTapped(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    // MARK: - Observers
    
    func initObservers() {
        addSearchBarObserver()
        addCollectionViewBindingObserver()
        addPaginationObserver()
        addOnTapObserver()
    }
    
    private func addSearchBarObserver() {
        searchController.searchBar.searchTextField.rx.text.orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe { value in
                if value.isEmpty {
                    self.currentPage = 1
                    self.totalPages = 1
                    self.searchResultItems.onNext([])
                } else {
                    self.rxSearchMovie(keyword: value, page: self.currentPage)
                }
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
    private func addCollectionViewBindingObserver() {
        searchResultItems.bind(to: collectionView.rx.items(cellIdentifier: String(describing: PopularMovieCollectionViewCell.self), cellType: PopularMovieCollectionViewCell.self)) { row, element, cell in
            cell.movie = element
        }
        .disposed(by: disposeBag)
    }
    
    private func addPaginationObserver() {
        Observable.combineLatest(
            collectionView.rx.willDisplayCell,
            searchController.searchBar.rx.text.orEmpty
        )
        .subscribe { cellTuple, text in
            let (_, indexPath) = cellTuple
            let totalItems = try! self.searchResultItems.value().count
            let isLastRow = indexPath.row == totalItems - 1
            
            if isLastRow && self.currentPage <= self.totalPages {
                self.currentPage += 1
                self.rxSearchMovie(keyword: text, page: self.currentPage)
            }
        } onError: { error in
            print("\(#function) \(error)")
        }
        .disposed(by: disposeBag)
    }
    
    private func addOnTapObserver() {
        collectionView.rx.itemSelected
            .subscribe { indexPath in
                let items = try! self.searchResultItems.value()
                let item = items[indexPath.row]
                let vc = MovieDetailViewController.instantiate()
                vc.movieId = item.id ?? -1
                self.navigationController?.pushViewController(vc, animated: true)
            } onError: { error in
                print("\(#function) \(error)")
            }
            .disposed(by: disposeBag)
    }
    
}

