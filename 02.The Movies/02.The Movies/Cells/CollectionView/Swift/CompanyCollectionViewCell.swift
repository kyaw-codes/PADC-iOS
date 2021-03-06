//
//  CompanyCollectionViewCell.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 01/07/2021.
//

import UIKit

class CompanyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    var company: ProductionCompany? {
        didSet {
            guard let company = company else {
                return
            }
            
            if let path = company.logoPath {
                let logoUrlString = "\(imageBaseURL)/\(path)"
                companyImageView.sd_setImage(with: URL(string: logoUrlString))
                companyNameLabel.text = ""
            } else {
                companyNameLabel.text = company.name
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
