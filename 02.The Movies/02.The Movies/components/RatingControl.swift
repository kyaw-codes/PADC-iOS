//
//  RatingControl.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 29/01/2021.
//

import UIKit

@IBDesignable
class RatingControl: UIStackView {
    
    @IBInspectable
    var starCount: Int = 3 {
        didSet {
            setUpButtons()
            setUpRating()
        }
    }

    @IBInspectable
    var starSize: CGSize = .init(width: 150, height: 150) {
        didSet {
            setUpButtons()
            setUpRating()
        }
    }
    
    @IBInspectable
    var rating: Int = 3 {
        didSet {
            setUpRating()
        }
    }
    
    var ratingButtons = [UIButton]()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpButtons()
        setUpRating()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpButtons()
        setUpRating()
    }
        
    fileprivate func setUpButtons() {
        clearExistingButtons()
        
        for _ in 0..<starCount {
            let button = UIButton(frame: .zero)
            button.setImage(#imageLiteral(resourceName: "ic_star_empty"), for: .normal)
            button.setImage(#imageLiteral(resourceName: "ic_star_filled"), for: .selected)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.isUserInteractionEnabled = false

            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: starSize.width),
                button.heightAnchor.constraint(equalToConstant: starSize.height)
            ])
            
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
    
    fileprivate func setUpRating() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    fileprivate func clearExistingButtons() {
        ratingButtons.forEach { removeArrangedSubview($0); $0.removeFromSuperview() }
        ratingButtons.removeAll()
    }


}
