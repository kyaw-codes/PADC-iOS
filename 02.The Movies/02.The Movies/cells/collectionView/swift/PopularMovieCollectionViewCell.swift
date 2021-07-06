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
            
            if let imagePath = data.posterPath {
                popularImageView.sd_setImage(with: URL(string: "\(imageBaseURL)/\(imagePath)"))
            }
            
            if let title = data.title {
                movieNameLabel.text = title
            } else {
                movieNameLabel.text = data.name
            }
            
            ratingLabel.text = String(format: "%.1f", data.voteAverage ?? 0)
            ratingControl.rating = Int(round(data.voteAverage ?? 0 * 0.5))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
