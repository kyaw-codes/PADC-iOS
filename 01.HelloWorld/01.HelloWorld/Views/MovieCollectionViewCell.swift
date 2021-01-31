//
//  MovieCollectionViewCell.swift
//  01.HelloWorld
//
//  Created by Ko Kyaw on 22/01/2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let IDENTIFIRE = "MovieCollectionViewCell_ID"
    
    var movie: String? {
        didSet {
            if let movie = movie {
                imageView.image = UIImage(named: movie)
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
