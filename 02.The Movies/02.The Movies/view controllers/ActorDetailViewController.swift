//
//  ActorDetailViewController.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 07/07/2021.
//

import UIKit

class ActorDetailViewController: UIViewController, Storyboarded {
    
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
    
    var actorDetail: ActorDetailResponse? {
        didSet {
            bindData()
        }
    }
    
    private var dbService = MovieDbService.shared
    private var movies: [Movie] = []
    
    var id: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDetial()
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
    
    private func fetchDetial() {
        dbService.fetchActorDetail(actorId: id) { [weak self] result in
            do {
                self?.actorDetail = try result.get()
                self?.navigationItem.title = self?.actorDetail?.name
            } catch {
                print(error)
            }
        }
        
        dbService.fetchMovies(of: id) { [weak self] result in
            do {
                let result = try result.get()
                result.movies?.forEach { self?.movies.append($0.convertToMovie()) }
                self?.moviesCollectionView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
    private func bindData() {
        guard let actorDetail = actorDetail else {
            return
        }
        
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

extension ActorDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: PopularMovieCollectionViewCell.self, for: indexPath, shouldRegister: true) { [weak self] cell in
            
            cell.movie = self?.movies[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        self.onItemTap(
            movieId: movie.id,
            type: (movie.mediaType ?? "movie") == "tv"
                ? .tv
                : .movie
        )
    }
}

extension ActorDetailViewController: MovieItemDelegate {
    func onItemTap(movieId: Int?, type: MovieDbService.ContentType) {
        let vc = MovieDetailViewController.instantiate()
        vc.movieId = movieId ?? -1
        vc.contentType = type
        navigationController?.pushViewController(vc, animated: true)
    }
}
