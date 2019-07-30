//
//  VideoViewController.swift
//

import UIKit
import youtube_ios_player_helper

class VideoViewController: UIViewController {
    
    var videoId: String?
    
    static func instantiate() -> VideoViewController {
        return VideoViewController(nibName: "\(self)", bundle: nil)
    }

    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.color = .red
        
        playerView.delegate = self
        
        playVideo(withId: videoId ?? "")
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap(gesture:))))
    }
    
    func playVideo(withId: String) {
        
        playerView.load(
            withVideoId: withId,
            playerVars: [
                "allowfullscreen" : 0,
                "playsinline" : 1
            ])
    }
    
    @objc func didTap(gesture: UITapGestureRecognizer) {
        if gesture.view == view {
            view.removeFromSuperview()
        }
    }

    
    func stopVideo() {
        view.removeFromSuperview()
    }
}

extension VideoViewController: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        loadingIndicator.stopAnimating()
        playerView.playVideo()
    }
    
}
