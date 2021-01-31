//
//  MainViewController.swift
//  01.HelloWorld
//
//  Created by Ko Kyaw on 22/01/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var showButton: UIButton!
    
    @IBOutlet weak var goToTableViewButton: UIButton!
    @IBOutlet weak var goToCollectionViewButton: UIButton!
        
    // MARK: - Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextField.layer.borderColor = UIColor.orange.cgColor
        inputTextField.layer.borderWidth = 1.0
        inputTextField.layer.cornerRadius = 10
        
        inputTextField.delegate = self
        
        [showButton, goToTableViewButton, goToCollectionViewButton].forEach { $0.layer.cornerRadius = 10 }
        
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onProfileImageTap(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        debugPrint("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        debugPrint("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        debugPrint("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        debugPrint("viewDidDisappear")
    }
    
    // MARK: - IBActions
    
    @IBAction func didShouButtonTap(_ sender: UIButton) {
        nameLabel.text = inputTextField.text
        inputTextField.text = ""
        inputTextField.resignFirstResponder()
    }

    
    // MARK: - Event Handlers
    
    @objc func onProfileImageTap(_ sender: UIImageView) {
        inputTextField.text = ""
        inputTextField.resignFirstResponder()
        nameLabel.text = "Kyaw the Monkey 🐵"
    }
    
}

// MARK: - UITextFieldDelegate Extension

extension MainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameLabel.text = textField.text
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
