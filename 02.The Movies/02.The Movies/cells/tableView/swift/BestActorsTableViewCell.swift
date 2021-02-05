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

    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreActorsLabel.underline(for: "MORE ACTORS")
        bestActorsCollectionView.delegate = self
        bestActorsCollectionView.dataSource = self
        
        bestActorsCollectionView.registerCellWithNib(BestActorsCollectionViewCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension BestActorsTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueCollectionViewCell(ofType: BestActorsCollectionViewCell.self, with: collectionView, for: indexPath)
        cell.actorActionDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
    }
    
}

extension BestActorsTableViewCell: ActorActionDelegate {
    func onFavouriteTap(isFavourite: Bool) {
        debugPrint("isFavourite: \(isFavourite)")
    }

}
