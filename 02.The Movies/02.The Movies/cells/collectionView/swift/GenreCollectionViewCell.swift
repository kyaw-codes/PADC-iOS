//
//  MovieGenreCollectionViewCell.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/01/2021.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overlayView: UIView!
    
    var onGenreTap: ((String) -> Void) = {_ in}
    
    var data: GenreVO? = nil {
        didSet {
            if let data = data {
                genreLabel.text = data.genreName
                overlayView.isHidden = !data.isSelected
                genreLabel.textColor = data.isSelected ? .white : .init(red: 63/255, green: 69/255, blue: 96/255, alpha: 1)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Add gesture recognizer to the whole view
        containerView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(_didCellTap)))
    }
    
    @objc fileprivate func _didCellTap() {
        onGenreTap(data?.genreName ?? "")
    }

}
