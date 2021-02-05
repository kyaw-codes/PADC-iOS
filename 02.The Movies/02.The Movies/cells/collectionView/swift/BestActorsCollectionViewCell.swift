//
//  BestActorsCollectionViewCell.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 04/02/2021.
//

import UIKit

class BestActorsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var heartFilledImageView: UIImageView!
    
    var actorActionDelegate: ActorActionDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeGestureRecognizer()
    }
    
    fileprivate func initializeGestureRecognizer() {
        heartImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapFavourite)))
        heartFilledImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapUnfavourite)))
        
        [heartImageView, heartFilledImageView].forEach { $0?.isUserInteractionEnabled = true }
    }
    
    @objc fileprivate func onTapFavourite() {
        heartImageView.isHidden = true
        heartFilledImageView.isHidden = false
        actorActionDelegate?.onFavouriteTap(isFavourite: true)
    }
    
    @objc fileprivate func onTapUnfavourite() {
        heartImageView.isHidden = false
        heartFilledImageView.isHidden = true
        actorActionDelegate?.onFavouriteTap(isFavourite: false)
    }

}
