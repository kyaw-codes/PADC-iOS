//
//  DetailBadgeCollectionViewCell.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 06/07/2021.
//

import UIKit

class GenreBadgeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    
    var genre: Genre? {
        didSet {
            textLabel.text = genre?.name
            placeholderView.layer.cornerRadius = 12
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
