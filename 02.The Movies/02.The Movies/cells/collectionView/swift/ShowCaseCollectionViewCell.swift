//
//  ShowCaseCollectionViewCell.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 30/01/2021.
//

import UIKit

class ShowCaseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var showDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 4
        containerView.clipsToBounds = true
    }

}
