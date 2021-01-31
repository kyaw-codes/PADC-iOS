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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreShowCasesLabel.underline(for: "MORE SHOWCASES")
        
        showcaseCollectionView.dataSource = self
        showcaseCollectionView.delegate = self
        
        showcaseCollectionView.registerCellWithNib(ShowCaseCollectionViewCell.self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension ShowcaseTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueCollectionViewCell(ofType: ShowCaseCollectionViewCell.self, with: collectionView, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width * 0.8, height: collectionView.frame.height - 46)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Getting horizontal indicator which is index 0, from scroll view
        let horizontalScrollView = scrollView.subviews[(scrollView.subviews.count - 1)].subviews[0]
        horizontalScrollView.backgroundColor = UIColor(named: "Color_Yellow")
    }
    
}
