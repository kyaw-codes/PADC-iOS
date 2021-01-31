//
//  CheckShowtimeTableViewCell.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/01/2021.
//

import UIKit

class CheckShowtimeTableViewCell: UITableViewCell {

    @IBOutlet weak var checkMovieContainerView: UIView!
    @IBOutlet weak var seeMoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkMovieContainerView.layer.cornerRadius = 4
        seeMoreLabel.underline(for: "SEE MORE", color: UIColor.init(named: "Color_Yellow") ?? .white)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
