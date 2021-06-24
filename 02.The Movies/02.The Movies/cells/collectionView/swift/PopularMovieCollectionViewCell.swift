//
//  PopularMoviesCollectionViewCell.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/01/2021.
//

import UIKit
import SDWebImage

class PopularMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var popularImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    
    var movie: Movie? {
        didSet {
            guard let data = movie else { return }
            
            if let imagePath = data.backdropPath {
                popularImageView.sd_setImage(with: URL(string: "\(imageBaseURL)/\(imagePath)"))
            }
            movieNameLabel.text = data.originalTitle
            ratingLabel.text = "\(data.voteAverage)"
            ratingControl.rating = Int(round(data.voteAverage * 0.5))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
