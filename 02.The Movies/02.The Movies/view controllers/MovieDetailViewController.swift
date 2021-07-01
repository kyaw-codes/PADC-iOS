//
//  MovieDetailViewController.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 04/05/2021.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController, Storyboarded {

    @IBOutlet weak var playTrailerButton: UIButton!
    @IBOutlet weak var rateMovieButton: UIButton!
    @IBOutlet weak var companiesCollectionView: UICollectionView!
    @IBOutlet weak var actorsCollectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var releasedYearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var ratingControlView: RatingControl!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var storylineLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var companiesLabel: UILabel!
    @IBOutlet weak var releasedDateLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    var movieId: Int = -1
    
    private let dbService = MovieDbService.shared
    private var companies: [ProductionCompany]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradient()
        
        playTrailerButton.layer.cornerRadius = playTrailerButton.frame.height / 2
        rateMovieButton.layer.borderColor = UIColor.white.cgColor
        rateMovieButton.layer.borderWidth = 1
        rateMovieButton.layer.cornerRadius = rateMovieButton.frame.height / 2
        
        
        actorsCollectionView.dataSource = self
        actorsCollectionView.delegate = self
        
        companiesCollectionView.dataSource = self
        companiesCollectionView.delegate = self
        
        fetchDetail()
    }
    
    private func fetchDetail() {
        dbService.fetchMovie(of: movieId) { [weak self] result in
            do {
                let movieDetail = try result.get()
                self?.bindData(with: movieDetail)
            } catch {
                print(error)
            }
        }
    }
    
    private func bindData(with detail: MovieDetailResponse) {
        let imagePath = "\(imageBaseURL)/\(detail.backdropPath ?? "")"
        backgroundImageView.sd_setImage(with: URL(string: imagePath))
        releasedYearLabel.text = String(detail.releaseDate?.split(separator: "-").first ?? "")
        titleLabel.text = detail.title
        
        let hour = (detail.runtime ?? 0) / 60
        let minute = (detail.runtime ?? 0) - hour * 60
        durationLabel.text = "\(hour)h \(minute)min"
        
        voteCountLabel.text = "\(String((detail.voteCount ?? 0))) VOTES"
        ratingControlView.rating = Int((detail.voteAverage ?? 0) * 0.5)
        popularityLabel.text = String(format: "%.1f", detail.popularity ?? 0)
        storylineLabel.text = detail.overview
        originalTitleLabel.text = detail.originalTitle
        
        var rawGenres = detail.genres?.map { $0.name }.reduce("") { "\($0 ?? "") \($1), " }
        rawGenres?.removeLast(2)
        genresLabel.text = rawGenres ?? ""
        
        var rawCompanies = detail.productionCompanies?.map { $0.name }.reduce("") { "\($0 ?? "") \($1 ?? ""), " }

        if let company = rawCompanies, company.count > 2 {
            rawCompanies!.removeLast(2)
        }
        
        companiesLabel.text = rawCompanies
        
        releasedDateLabel.text = detail.releaseDate
        movieDescriptionLabel.text = detail.overview
        
        companies = detail.productionCompanies
        companiesCollectionView.reloadData()
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
        if collectionView == companiesCollectionView {
            return companies?.count ?? 0
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == companiesCollectionView {
            let cell = collectionView.dequeueCell(ofType: CompanyCollectionViewCell.self, for: indexPath, shouldRegister: true)
            if let company = companies?[indexPath.row] {
                cell.company = company
            }
            return cell
        } else {
            let cell = collectionView.dequeueCell(ofType: BestActorsCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.actorActionDelegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == companiesCollectionView {
            let width = 140
            return .init(width: width, height: width)
        } else {
            return .init(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
        }
    }
}

extension MovieDetailViewController : ActorActionDelegate {
    func onFavouriteTap(isFavourite: Bool) {
        // DO SOMETHING
    }
}
