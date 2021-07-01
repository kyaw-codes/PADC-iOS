//
//  BestActorsTableViewCell.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 04/02/2021.
//

import UIKit

class BestActorsTableViewCell: UITableViewCell {

    @IBOutlet weak var bestActorsCollectionView: UICollectionView!
    @IBOutlet weak var moreActorsLabel: UILabel!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var actors: [Actor]? {
        didSet {
            bestActorsCollectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreActorsLabel.underline(for: "MORE ACTORS")
        bestActorsCollectionView.delegate = self
        bestActorsCollectionView.dataSource = self
        
        let width = bestActorsCollectionView.frame.width * 0.35
        let height = width + width * 0.5
        collectionViewHeight.constant = height
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension BestActorsTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: BestActorsCollectionViewCell.self, for: indexPath, shouldRegister: true)
        cell.actorActionDelegate = self
        cell.bestActor = actors?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * 0.35
        let height = width + width * 0.5
        return .init(width: width, height: height)
    }
    
}

extension BestActorsTableViewCell: ActorActionDelegate {
    func onFavouriteTap(isFavourite: Bool) {
        debugPrint("isFavourite: \(isFavourite)")
    }

}
