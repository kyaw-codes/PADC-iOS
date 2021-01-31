//
//  ContactListViewController.swift
//  01.HelloWorld
//
//  Created by Ko Kyaw on 22/01/2021.
//

import UIKit

class ContactListViewController: UIViewController, UITableViewDataSource {

    fileprivate let contacts = PhoneBook.fetch()

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: ContactTableViewCell.IDENTIFIRE)
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contacts[section].category.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentSection = indexPath.section

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.IDENTIFIRE, for: indexPath) as? ContactTableViewCell else {
            fatalError("ERROR: The given cell cannot be converted into ContactTableViewCell")
        }
        
        cell.contact = contacts[currentSection].contacts[indexPath.item]
        
        switch currentSection {
        case 0:
            cell.backgroundColor = .lightGreen
        case 1:
            cell.backgroundColor = .lightBlue
        case 2:
            cell.backgroundColor = .lightYellow
        default:
            cell.backgroundColor = .lightGreen
        }
        
        return cell
    }
    
}
