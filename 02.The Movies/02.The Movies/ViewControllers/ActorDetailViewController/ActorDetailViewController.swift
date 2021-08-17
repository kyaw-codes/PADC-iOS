//
//  ActorDetailViewController.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 07/07/2021.
//

import UIKit

class ActorDetailViewController: UIViewController, Storyboarded {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailAkaLabel: UILabel!
    @IBOutlet weak var detailBirthdayLabel: UILabel!
    @IBOutlet weak var detailBirthPlaceLabel: UILabel!
    @IBOutlet weak var detailRoleLabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!

    // MARK: - Properties
    
    var actorDetail: ActorDetailResponse? {
        didSet {
            guard let actorDetail = actorDetail else {
                return
            }
            bindData(with: actorDetail)
        }
    }
    
    let actorModel: ActorModel = ActorModelImpl.shared
    var movies: [Movie] = []
    var id: Int = -1

    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadDetailData()
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        let height = self.view.frame.width + self.view.frame.width * 0.5
        imageHeightConstraint.constant = height
        
        if profileImageView.layer.sublayers == nil {
            setupGradientLayer(height)
        }
    }
    
    // MARK: - Private Helpers
    
    private func bindData(with actorDetail: ActorDetailResponse) {
        if let imagePath = actorDetail.profilePath {
            let imageUrlString = "\(imageBaseURL)/\(imagePath)"
            profileImageView.sd_setImage(with: URL(string: imageUrlString))
        }
        
        nameLabel.text = actorDetail.name
        roleLabel.text = (actorDetail.gender ?? 1) == 1 ? "Actress" : "Actor"
        popularityLabel.text = String(format: "%.2f", actorDetail.popularity ?? 0.0)
        biographyLabel.text = actorDetail.biography
        detailNameLabel.text = actorDetail.name
        
        var rawAkaNames = actorDetail.alsoKnownAs?.map { $0 }.reduce("") { "\($0 ?? "") \($1), " }

        if let akaNames = rawAkaNames, akaNames.count > 2 {
            rawAkaNames!.removeLast(2)
        }
        
        detailAkaLabel.text = rawAkaNames
        
        detailBirthdayLabel.text = actorDetail.birthday
        detailBirthPlaceLabel.text = actorDetail.placeOfBirth
        detailRoleLabel.text = (actorDetail.gender ?? 1) == 1 ? "Actress" : "Actor"
    }
    
    private func setupGradientLayer(_ imageViewHeight: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.init(named: "Color_Primary")!.cgColor]
        gradientLayer.locations = [0, 0.9]
        profileImageView.layer.addSublayer(gradientLayer)
        
        let gradientHeight = imageViewHeight * 0.5

        gradientLayer.frame = CGRect(x: 0, y: imageViewHeight - gradientHeight, width: self.view.frame.width, height: gradientHeight)
    }
    
}
