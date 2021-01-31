//
//  ContactTableViewCell.swift
//  01.HelloWorld
//
//  Created by Ko Kyaw on 22/01/2021.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    
    var contact: Contact? {
        didSet {
            if let contact = contact {
                nameLabel.text = contact.name
                phoneLabel.text = contact.phone
            }
        }
    }
    
    static let IDENTIFIRE = "ContactTableViewCell_ID"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
