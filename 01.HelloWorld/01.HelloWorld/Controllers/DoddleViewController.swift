//
//  ViewController.swift
//  01.HelloWorld
//
//  Created by Ko Kyaw on 21/01/2021.
//

import UIKit

class DoddleViewController: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        main()
        nextButton.layer.cornerRadius = 10
    }

}

