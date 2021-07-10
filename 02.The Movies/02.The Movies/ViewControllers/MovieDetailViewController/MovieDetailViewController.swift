//
//  MovieDetailViewController.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 04/05/2021.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController, Storyboarded {

    // MARK: - IBOutlets
    
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
    @IBOutlet weak var badgeCollectionView: UICollectionView!
    @IBOutlet weak var similarMoviesCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    var movieId: Int = -1
    var contentType: MovieDbService.ContentType = .movie
    
    var companies: [ProductionCompany]?
    var movieDetail: MovieDetailResponse?
    var actors: [Actor]?
    var similarMovies: [Movie]?
    
    let dbService = MovieDbService.shared

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradient()
        configureButtons()
        
        [actorsCollectionView, companiesCollectionView, badgeCollectionView, similarMoviesCollectionView].forEach {
            $0?.delegate = self
            $0?.dataSource = self
        }
                                
        fetchContents()
    }
    
    // MARK: - Helpers
    
    func bindData(with detail: MovieDetailResponse?) {
        guard let detail = detail else {
            return
        }

        let imagePath = "\(imageBaseURL)/\(detail.backdropPath ?? "")"
        backgroundImageView.sd_setImage(with: URL(string: imagePath))

        if contentType == .movie {
            releasedYearLabel.text = String(detail.releaseDate?.split(separator: "-").first ?? "")
            releasedDateLabel.text = detail.releaseDate
            originalTitleLabel.text = detail.originalTitle
            titleLabel.text = detail.title

            let hour = (detail.runtime ?? 0) / 60
            let minute = (detail.runtime ?? 0) - hour * 60
            durationLabel.text = "\(hour)h \(minute)min"
        } else {
            releasedYearLabel.text = String(detail.lastAirDate?.split(separator: "-").first ?? "")
            releasedDateLabel.text = detail.lastAirDate
            originalTitleLabel.text = detail.originalName
            titleLabel.text = detail.name
            
            durationLabel.text = "\(detail.noOfSeasons ?? 1) \((detail.noOfSeasons ?? 1) > 1 ? "Seasons" : "Season")"
        }

        voteCountLabel.text = "\(String((detail.voteCount ?? 0))) VOTES"
        ratingControlView.rating = Int((detail.voteAverage ?? 0) * 0.5)
        popularityLabel.text = String(format: "%.1f", detail.popularity ?? 0)
        storylineLabel.text = detail.overview
        
        var rawGenres = detail.genres?.map { $0.name }.reduce("") { "\($0 ?? "") \($1), " }
        if (rawGenres?.count ?? 0) >= 2 {
            rawGenres?.removeLast(2)
        }
        genresLabel.text = rawGenres ?? ""
        
        var rawCompanies = detail.productionCompanies?.map { $0.name }.reduce("") { "\($0 ?? "") \($1 ?? ""), " }

        if let company = rawCompanies, company.count > 2 {
            rawCompanies!.removeLast(2)
        }
        
        companiesLabel.text = rawCompanies
        
        movieDescriptionLabel.text = detail.overview
        
        companies = detail.productionCompanies
        companiesCollectionView.reloadData()
        badgeCollectionView.reloadData()
    }
    
    // MARK: - Target/Action Handlers
    
    @IBAction private func onPlayTrailerTapped(_ sender: Any) {
        self.downloadVideoAndPlay()
    }
}
