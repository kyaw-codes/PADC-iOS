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
    
    fileprivate var genreList: [GenreVO] = [
        .init(genreName: "ACTION", isSelected: true),
        .init(genreName: "ADVENTURE", isSelected: false),
        .init(genreName: "CRIMINAL", isSelected: false),
        .init(genreName: "DRAMMA", isSelected: false),
        .init(genreName: "COMEDY", isSelected: false),
        .init(genreName: "DOCUMENTARY", isSelected: false),
        .init(genreName: "BIOGRAPHY", isSelected: false)
    ]
    
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
        return collectionView == genreCollectionView ? genreList.count : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == genreCollectionView {
            return collectionView.dequeueCell(ofType: GenreCollectionViewCell.self, for: indexPath, shouldRegister: true) { [weak self] cell in
                guard let self = self else { return }
                // Pass data to the cell
                cell.data = self.genreList[indexPath.row]
                
                // Implement on tap event
                cell.onGenreTap = { genreName in
                    self.resetGenreSelection(genreName)
                    self.genreCollectionView.reloadData()
                }
            }
            
        } else {
            return collectionView.dequeueCell(ofType: PopularMovieCollectionViewCell.self, for: indexPath, shouldRegister: true)
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == genreCollectionView {
            let textWidth = getWidthOf(text: genreList[indexPath.row].genreName, with: UIFont(name: "Geeza Pro Regular", size: 14) ?? UIFont.systemFont(ofSize: 14))
            
            return .init(width: textWidth + 20, height: 40)
        } else {
            return .init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        }
        
    }
    
    fileprivate func resetGenreSelection(_ genreName: String) {
        genreList.forEach { genre  in
            if genre.genreName == genreName {
                genre.isSelected = true
            } else {
                genre.isSelected = false
            }
        }
    }

    fileprivate func getWidthOf(text: String, with font: UIFont) -> CGFloat {
        let attribute = [NSAttributedString.Key.font: font]
        let size = text.size(withAttributes: attribute)
        return size.width
    }
    
}
