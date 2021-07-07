//
//  YoutubePlayerViewController.swift
//  02.The Movies
//
//  Created by Ko Kyaw on 07/07/2021.
//

import UIKit
import YouTubePlayer

class YoutubePlayerViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var youtubePlayerView: YouTubePlayerView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var keyPath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let keyPath = keyPath else {
            return
        }
        
        youtubePlayerView.loadVideoID(keyPath)
        youtubePlayerView.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        heightConstraint.constant = (self.view.frame.width * 9) / 16
    }
    
    @IBAction private func onCancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
