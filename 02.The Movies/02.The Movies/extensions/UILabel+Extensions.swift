//
//  UILabel+Extensions.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 30/01/2021.
//

import UIKit

extension UILabel {
    
    func underline(for text: String, color: UIColor = .white) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes([NSAttributedString.Key.underlineStyle : 2, NSAttributedString.Key.underlineColor: color], range: NSRange.init(location: 0, length: text.count))
        attributedText = attributedString
    }
}
