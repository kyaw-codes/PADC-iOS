//
//  SearchViewController+UI.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 10/07/2021.
//

import UIKit

extension SearchViewController {
    
    func setupSearchBar() {
        let searchBar = searchController.searchBar
        searchBar.delegate = self
        
        let colorYellow = UIColor(named: "Color_Yellow")!
        
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField,
           let iconView = textFieldInsideSearchBar.leftView as? UIImageView {
            
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = colorYellow
        }
        searchBar.backgroundColor = UIColor(named: "Color_Primary")
        searchBar.tintColor = colorYellow
        searchBar.searchTextField.textColor = colorYellow
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search with keywords", attributes: [.foregroundColor: UIColor.systemGray])
    }
    
    func setupUpButton() {
        let upImage = UIImage(systemName: "chevron.up.circle.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 40)))
        upButton.setImage(upImage, for: .normal)
        upButton.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
}
