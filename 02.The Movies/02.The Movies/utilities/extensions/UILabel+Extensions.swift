//
//  UILabel+Extensions.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 30/01/2021.
//

import UIKit

extension UILabel {
    
    /// Underline the given string.
    /// - Parameters:
    ///   - text: Any text to be underlined
    ///   - color: The underline color. Default is white
    func underline(for text: String, color: UIColor = .white) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes([NSAttributedString.Key.underlineStyle : 2, NSAttributedString.Key.underlineColor: color], range: NSRange.init(location: 0, length: text.count))
        attributedText = attributedString
    }
}
