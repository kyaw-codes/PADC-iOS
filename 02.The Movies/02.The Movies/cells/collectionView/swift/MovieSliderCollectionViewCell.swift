//
//  MovieSliderCollectionViewCell.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/01/2021.
//

import UIKit

class MovieSliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLable: UILabel!
    @IBOutlet weak var playImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupGradientLayer()
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor(named: "Color_Primary")!.cgColor]
        gradientLayer.locations = [0, 0.5]
        movieImageView.layer.addSublayer(gradientLayer)
        let gradientHeight = movieImageView.frame.height * 0.5
        gradientLayer.frame = CGRect(x: 0, y: movieImageView.frame.height - gradientHeight, width: movieImageView.frame.width, height: gradientHeight)
    }

}
