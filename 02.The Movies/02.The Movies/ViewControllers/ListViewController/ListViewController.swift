//
//  ActorsViewController.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 07/07/2021.
//

import UIKit

class ListViewController: UIViewController, Storyboarded {
    
    enum ListType {
        case casts
        case movies
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var upButton: UIButton!

    // MARK: - Properties
    
    var actorResponse: ActorResponse?
    var movieResponse: MovieResponse?
    
    var type: ListType = .casts

    var noOfCols: CGFloat = 3
    var spacing: CGFloat = 10
    var currentPage = 1
    var noOfPages = 1
    
    var actors: [Actor] = []
    var movies: [Movie] = []
    var movieService = NetworkAgentImpl.shared
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupInitialData()
        setupUpButton()
        
        navigationItem.title = type == .casts ? "All Actors" : "Top Rated Movies"
    }
    
    // MARK: - Helpers
    
    private func setupInitialData() {
        if type == .casts {
            actorResponse?.actors?.forEach {
                actors.append($0)
            }
            currentPage = actorResponse?.page ?? 1
            noOfPages = actorResponse?.totalPages ?? 1
        } else {
            movieResponse?.movies.forEach {
                movies.append($0)
            }
            currentPage = movieResponse?.page ?? 1
            noOfPages = movieResponse?.totalPages ?? 1
        }
        collectionView.reloadData()
    }
    
    private func setupUpButton() {
        let upImage = UIImage(systemName: "chevron.up.circle.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 36)))
        upButton.setImage(upImage, for: .normal)
        upButton.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    // MARK: - Target/Action Handler
    
    @IBAction private func onUpButtonTapped(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
}
