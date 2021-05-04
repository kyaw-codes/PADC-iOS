//
//  MovieDetailViewController.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 04/05/2021.
//

import UIKit

class MovieDetailViewController: UIViewController, Storyboarded {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var playTrailerButton: UIButton!
    @IBOutlet weak var rateMovieButton: UIButton!
    
    @IBOutlet weak var actorsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradient()
        
        playTrailerButton.layer.cornerRadius = playTrailerButton.frame.height / 2
        rateMovieButton.layer.borderColor = UIColor.white.cgColor
        rateMovieButton.layer.borderWidth = 1
        rateMovieButton.layer.cornerRadius = rateMovieButton.frame.height / 2
        
        actorsCollectionView.dataSource = self
        actorsCollectionView.delegate = self
        actorsCollectionView.registerCellWithNib(BestActorsCollectionViewCell.self)
    }
    
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.init(named: "Color_Dark_Blue")!.cgColor]
        gradientLayer.locations = [0, 0.9]
        backgroundImageView.layer.addSublayer(gradientLayer)

        let gradientHeight = backgroundImageView.frame.height * 0.5
        gradientLayer.frame = CGRect(x: 0, y: backgroundImageView.frame.height - gradientHeight, width: view.frame.width, height: gradientHeight)
    }
    
    @IBAction func onBackTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueCollectionViewCell(ofType: BestActorsCollectionViewCell.self, with: collectionView, for: indexPath)
        cell.actorActionDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
    }
}

extension MovieDetailViewController : ActorActionDelegate {
    func onFavouriteTap(isFavourite: Bool) {
        // DO SOMETHING
    }
}
