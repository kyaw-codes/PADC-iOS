//
//  UIColor+Extension.swift
//  01.HelloWorld
//
//  Created by Ko Kyaw on 22/01/2021.
//

import UIKit

extension UIColor {
    
    class var lightGreen: UIColor {
        get {
            return .init(red: 184/255, green: 218/255, blue: 169/255, alpha: 1)
        }
    }
    
    class var lightBlue: UIColor {
        get {
            return .init(red: 167/255, green: 217/255, blue: 244/255, alpha: 1)
        }
    }
    
    class var lightYellow: UIColor {
        get {
            return .init(red: 254/255, green: 238/255, blue: 157/255, alpha: 1)
        }
    }
}
