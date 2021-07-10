//
//  MovieWithGenreTableViewCell.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/01/2021.
//

import UIKit

class MovieWithGenreTableViewCell: UITableViewCell {

    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var genreList: [GenreVO]? {
        didSet {
            // Clean up genres
            genreList?.removeAll(where: { vo in
                return movieDict[vo.id] == nil
            })
            
            genreList?.first?.isSelected = true
            genreCollectionView.reloadData()
            
            reloadMovies(basedOn: genreList?.first?.id ?? 0)
        }
    }
    
    var delegate: MovieItemDelegate?
    
    var movies: [Movie]? {
        didSet {
            guard let movies = movies else { return }
            organizeMoviesBasedOnGenre(movies)
        }
    }
    
    private var movieDict: [Int: Set<Movie>] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self

        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MovieWithGenreTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == genreCollectionView {
            return genreList?.count ?? 0
        } else {
            return movies?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == genreCollectionView {
            return collectionView.dequeueCell(ofType: GenreCollectionViewCell.self, for: indexPath, shouldRegister: true) { [weak self] cell in
                guard let self = self else { return }
                // Pass data to the cell
                cell.data = self.genreList?[indexPath.row]
                
                // Implement on tap event
                cell.onGenreTap = { genreId in
                    self.resetGenreSelection(genreId)
                    self.reloadMovies(basedOn: genreId)
                }
            }
            
        } else {
            let cell = collectionView.dequeueCell(ofType: PopularMovieCollectionViewCell.self, for: indexPath, shouldRegister: true)
            cell.movie = movies?[indexPath.row]
            return cell
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == genreCollectionView {
            let genreName = genreList?[indexPath.row].genreName ?? ""
            let textWidth = genreName.getWidth(of: UIFont(name: "Geeza Pro Regular", size: 14) ?? .systemFont(ofSize: 14))
            return .init(width: textWidth + 20, height: 40)
        } else {
            return .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onItemTap(movieId: movies?[indexPath.row].id, type: .movie)
    }
}

extension MovieWithGenreTableViewCell {
    
    // MARK: - Private Helpers

    private func resetGenreSelection(_ genreId: Int) {
        genreList?.forEach { genre  in
            if genre.id == genreId {
                genre.isSelected = true
            } else {
                genre.isSelected = false
            }
        }
        genreCollectionView.reloadData()
    }

    private func organizeMoviesBasedOnGenre(_ movies: [Movie]) {
        movies.forEach { movie in
            movie.genreIDS?.forEach { genreId in
                if let _ = movieDict[genreId] {
                    movieDict[genreId]?.insert(movie)
                } else {
                    movieDict[genreId] = [movie]
                }
            }
        }
    }
    
    private func reloadMovies(basedOn genreId: Int) {
        movies = movieDict[genreId]?.map { $0 }
        movieCollectionView.reloadData()
    }
    
}
