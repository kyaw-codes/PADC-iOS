//
//  ShowCaseTableViewCell.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 30/01/2021.
//

import UIKit

class ShowcaseTableViewCell: UITableViewCell {

    @IBOutlet weak var moreShowCasesLabel: UILabel!
    @IBOutlet weak var showcaseCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var movies: [Movie]? {
        didSet {
            showcaseCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreShowCasesLabel.underline(for: "MORE SHOWCASES")
        
        showcaseCollectionView.dataSource = self
        showcaseCollectionView.delegate = self
        
        let cellWidth = showcaseCollectionView.frame.width * 0.8
        let cellHeight = (cellWidth / 16) * 9
        let sectionInset: CGFloat = 16
        collectionViewHeight.constant = cellHeight + sectionInset
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension ShowcaseTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(ofType: ShowCaseCollectionViewCell.self, for: indexPath, shouldRegister: true)
        cell.movie = movies?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width * 0.8
        let cellHeight = (cellWidth / 16) * 9
        return .init(width: cellWidth, height: cellHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Getting horizontal indicator which is index 0, from scroll view
        let horizontalScrollView = scrollView.subviews[(scrollView.subviews.count - 1)].subviews[0]
        horizontalScrollView.backgroundColor = UIColor(named: "Color_Yellow")
    }
    
}
