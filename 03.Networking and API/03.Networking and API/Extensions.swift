//
//  Extensions.swift
//  03.Networking and API
//
//  Created by Ko Kyaw on 13/06/2021.
//

import UIKit

extension UIImage {
    
    static func downloaded(from path: String) async throws -> UIImage? {
        let url = URL(string: "\(baseImgURL)\(path)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }
}
