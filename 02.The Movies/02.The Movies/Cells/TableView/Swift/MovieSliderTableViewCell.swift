//
//  MovieSliderTableViewCell.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/01/2021.
//

import UIKit

class MovieSliderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieSliderCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var delegate: MovieItemDelegate?
    var movies: [Movie]? {
        didSet {
            pageControl.numberOfPages = movies?.count ?? 0
            movieSliderCollectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieSliderCollectionView.delegate = self
        movieSliderCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MovieSliderTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: MovieSliderCollectionViewCell.self, for: indexPath, shouldRegister: true)
        cell.movie = movies?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height:collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onItemTap(movieId: movies?[indexPath.row].id, type: .movie)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / contentView.frame.width)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / contentView.frame.width)
    }
    
}
