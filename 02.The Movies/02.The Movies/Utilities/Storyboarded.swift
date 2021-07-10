//
//  Storyboarded.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 04/05/2021.
//

import UIKit


protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: String(describing: self)) as! Self
    }
}
