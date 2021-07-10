//
//  String+Extensions.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 06/07/2021.
//

import UIKit

extension String {
 
    func getWidth(of font: UIFont) -> CGFloat {
        let attribute = [NSAttributedString.Key.font : font]
        let size = self.size(withAttributes: attribute)
        return size.width
    }
}
