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
    
    private let dbService = MovieDbService.shared
    private var companies: [ProductionCompany]?
    private var movieDetail: MovieDetailResponse?
    private var actors: [Actor]?
    private var similarMovies: [Movie]?
    
    // MARK: - Lifecycle
    
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
        
        badgeCollectionView.delegate = self
        badgeCollectionView.dataSource = self
        
        similarMoviesCollectionView.delegate = self
        similarMoviesCollectionView.dataSource = self
        
        fetchDetail()
    }
    
    private func fetchDetail() {
        dbService.fetchMovie(of: movieId, contentType: self.contentType) { [weak self] result in
            do {
                self?.movieDetail = try result.get()
                self?.bindData(with: self?.movieDetail)
            } catch {
                print(error)
            }
        }
        fetchMovieCredits()
        fetchSimilarMovies()
    }
    
    private func fetchMovieCredits() {
        dbService.fetchActor(of: movieId, contentType: self.contentType) { [weak self] result in
            do {
                self?.actors = try result.get()
                self?.actorsCollectionView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private func fetchSimilarMovies() {
        dbService.fetchSimilarMovies(of: movieId, contentType: self.contentType) { [weak self] result in
            do {
                self?.similarMovies = try result.get()
                self?.similarMoviesCollectionView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private func bindData(with detail: MovieDetailResponse?) {
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
        rawGenres?.removeLast(2)
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
    
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.init(named: "Color_Dark_Blue")!.cgColor]
        gradientLayer.locations = [0, 0.8]
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
        } else if collectionView == badgeCollectionView {
            return movieDetail?.genres?.count ?? 0
        } else if collectionView == actorsCollectionView {
            return actors?.count ?? 0
        } else {
            return similarMovies?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == companiesCollectionView {
            let cell = collectionView.dequeueCell(ofType: CompanyCollectionViewCell.self, for: indexPath, shouldRegister: true)
            if let company = companies?[indexPath.row] {
                cell.company = company
            }
            return cell
        } else if collectionView == badgeCollectionView {
            let genre = movieDetail?.genres?[indexPath.row]
            let cell = collectionView.dequeueCell(ofType: GenreBadgeCollectionViewCell.self, for: indexPath, shouldRegister: true) { cell in
                cell.genre = genre
            }
            return cell
        } else if collectionView == actorsCollectionView {
            let cell = collectionView.dequeueCell(ofType: BestActorsCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.actorActionDelegate = self
            cell.bestActor = actors?[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueCell(ofType: PopularMovieCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.movie = similarMovies?[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == companiesCollectionView {
            let width = 100
            return .init(width: width, height: width)
        } else if collectionView == badgeCollectionView {
            let text = movieDetail?.genres?[indexPath.row].name ?? ""
            let textWidth = text.getWidth(of: UIFont(name: "Geeza Pro Regular", size: 15) ?? UIFont.systemFont(ofSize: 15))
            return .init(width: textWidth + 26, height: collectionView.frame.height)
        } else if collectionView == actorsCollectionView {
            let width = collectionView.frame.width * 0.35
            let height = width + width * 0.5
            return .init(width: width, height: height)
        } else {
            return .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == similarMoviesCollectionView {
            // Navigate to detail view controller
            let detailVC = MovieDetailViewController.instantiate()
            detailVC.modalPresentationStyle = .fullScreen
            detailVC.modalTransitionStyle = .flipHorizontal
            detailVC.movieId = similarMovies?[indexPath.row].id ?? -1
            detailVC.contentType = self.contentType
            present(detailVC, animated: true, completion: nil)
        }
    }
}

extension MovieDetailViewController : ActorActionDelegate {
    func onFavouriteTap(isFavourite: Bool) {
        // DO SOMETHING
    }
}
