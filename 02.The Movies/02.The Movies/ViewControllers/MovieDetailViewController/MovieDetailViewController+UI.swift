//
//  MovieDetailViewController+UI.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import UIKit

extension MovieDetailViewController {
    func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.init(named: "Color_Dark_Blue")!.cgColor]
        gradientLayer.locations = [0, 0.8]
        backgroundImageView.layer.addSublayer(gradientLayer)

        let gradientHeight = backgroundImageView.frame.height * 0.5
        gradientLayer.frame = CGRect(x: 0, y: backgroundImageView.frame.height - gradientHeight, width: view.frame.width, height: gradientHeight)
    }
    
    func configureButtons() {
        playTrailerButton.layer.cornerRadius = playTrailerButton.frame.height / 2
        rateMovieButton.layer.borderColor = UIColor.white.cgColor
        rateMovieButton.layer.borderWidth = 1
        rateMovieButton.layer.cornerRadius = rateMovieButton.frame.height / 2
    }
}
