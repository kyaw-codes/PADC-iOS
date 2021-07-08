//
//  ActorsViewController.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 07/07/2021.
//

import UIKit

class ActorsViewController: UIViewController, Storyboarded {
    
    var initialActors: ActorResponse?

    private var noOfCols: CGFloat = 3
    private var spacing: CGFloat = 10
    private var currentPage = 1
    private var noOfPages = 1
    
    private var actors: [Actor] = []
    private var movieService = MovieDbService.shared
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var upButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPage = initialActors?.page ?? 1
        noOfPages = initialActors?.totalPages ?? 1
        
        collectionView.delegate = self
        collectionView.dataSource = self
            
        initialActors?.actors?.forEach {
            actors.append($0)
        }
        collectionView.reloadData()
        
        setupUpButton()
        
    }
    
    private func fetchNextPage(pageNo: Int) {
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
    
    private func setupUpButton() {
        let upImage = UIImage(systemName: "chevron.up.circle.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 36)))
        upButton.setImage(upImage, for: .normal)
        upButton.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    @IBAction private func onUpButtonTapped(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
}

extension ActorsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.frame.width - 20 - ((noOfCols - 1) * spacing)) / noOfCols
        let height: CGFloat = width + width * 0.5
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = actors[indexPath.row]
        let cell = collectionView.dequeueCell(ofType: BestActorsCollectionViewCell.self, for: indexPath, shouldRegister: true) { cell in
            cell.bestActor = item
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let isLastRow = (indexPath.row == actors.count-1)
        
        if isLastRow && currentPage <= noOfPages {
            fetchNextPage(pageNo: currentPage + 1)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = actors[indexPath.row]
        self.onActorCellTapped(actorId: item.id)
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

extension ActorsViewController: ActorActionDelegate {
    func onFavouriteTapped(isFavourite: Bool) {
        // TODO: - Implement later
    }
    
}
