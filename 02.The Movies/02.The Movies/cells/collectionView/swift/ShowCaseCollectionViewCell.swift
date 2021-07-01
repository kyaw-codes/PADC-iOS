//
//  ShowCaseCollectionViewCell.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 30/01/2021.
//

import UIKit
import SDWebImage

class ShowCaseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var showDateLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            movieImageView.sd_setImage(with: URL(string: "\(imageBaseURL)/\(movie.backdropPath ?? "")"))
            movieNameLabel.text = movie.originalTitle
            showDateLabel.text = movie.releaseDate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 4
        containerView.clipsToBounds = true
    }

}
