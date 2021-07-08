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
    
    var actorResponse: ActorResponse?
    var movieResponse: MovieResponse?
    
    var type: ListType = .casts

    private var noOfCols: CGFloat = 3
    private var spacing: CGFloat = 10
    private var currentPage = 1
    private var noOfPages = 1
    
    private var actors: [Actor] = []
    private var movies: [Movie] = []
    private var movieService = MovieDbService.shared
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var upButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
            print(currentPage)
            print(noOfPages)
        }
        
        collectionView.reloadData()
        
        setupUpButton()
    }
    
    private func fetchNextPage(pageNo: Int) {
        if type == .casts {
            fetchActors(pageNo: pageNo)
        } else {
            fetchMovies(pageNo: pageNo)
        }
    }
    
    private func fetchActors(pageNo: Int) {
        movieService.fetchActors(with: "/person/popular", pageNo: pageNo) { [weak self] result in
            do {
                let actorResponse = try result.get()
                actorResponse.actors?.forEach {
                    self?.actors.append($0)
                }
                self?.collectionView.reloadData()
                self?.currentPage += 1
            } catch {
                print("[Error: while fetching Actors]", error)
            }
        }
    }
    
    private func fetchMovies(pageNo: Int) {
        movieService.fetchMovies(with: "/movie/top_rated", pageNo: pageNo) { [weak self] result in
            do {
                let movies = try result.get()
                movies.forEach {
                    self?.movies.append($0)
                }
                self?.collectionView.reloadData()
                self?.currentPage += 1
            } catch {
                print("[Error: while fetching top rated movies]", error)
            }
        }
    }
    
    private func setupUpButton() {
        let upImage = UIImage(systemName: "chevron.up.circle.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 36)))
        upButton.setImage(upImage, for: .normal)
        upButton.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    @IBAction private func onUpButtonTapped(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
}

extension ListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if type == .casts {
            let width: CGFloat = (collectionView.frame.width - 20 - ((noOfCols - 1) * spacing)) / noOfCols
            let height: CGFloat = width + width * 0.5
            return .init(width: width, height: height)
        } else {
            let width: CGFloat = collectionView.frame.width - 20
            let height: CGFloat = (width * 9) / 16
            return .init(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return type == .casts ? actors.count : movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if type == .casts {
            let item = actors[indexPath.row]
            let cell = collectionView.dequeueCell(ofType: BestActorsCollectionViewCell.self, for: indexPath, shouldRegister: true) { cell in
                cell.bestActor = item
            }
            return cell
        } else {
            let item = movies[indexPath.row]
            let cell = collectionView.dequeueCell(ofType: ShowCaseCollectionViewCell.self, for: indexPath, shouldRegister: true) { cell in
                cell.movie = item
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isLastRow = indexPath.row == (type == .casts
                                          ? actors.count - 1
                                          : movies.count - 1)
        
        if isLastRow && currentPage <= noOfPages {
            fetchNextPage(pageNo: currentPage + 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if type == .casts {
            let item = actors[indexPath.row]
            self.onActorCellTapped(actorId: item.id)
        } else {
            let vc = MovieDetailViewController.instantiate()
            vc.movieId = movies[indexPath.row].id ?? -1
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.frame.height / 2 {
            upButton.isHidden = false
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.upButton.transform = .identity
            }
        } else {
            if upButton.transform.isIdentity {
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.upButton.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                }
            }
        }
    }
}

extension ListViewController: ActorActionDelegate {
    func onFavouriteTapped(isFavourite: Bool) {
        // TODO: - Implement later
    }
    
}
