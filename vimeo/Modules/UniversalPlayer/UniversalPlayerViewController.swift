//
//  UniversalPlayerViewController.swift
//  vimeo
//
//  Created by Andrii Momot on 3/28/19.
//  Copyright © 2019 Andrii Momot. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import HCVimeoVideoExtractor

class UniversalPlayerViewController: BaseViewController {
    
    var model: UniversalPlayerModelProtocol? {
        return self.tempModel as? UniversalPlayerModelProtocol
    }
    
    var customView: UniversalPlayerViewProtocol? {
        return self.view as? UniversalPlayerViewProtocol
    }
    
    // MARK: Initializers
    var videoController: VideoViewController?
    
    init(withView view: UniversalPlayerViewProtocol, model: UniversalPlayerModelProtocol) {
        super.init(withView: view, model: model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        customView?.delegate = self
        model?.delegate = self
        customView?.videoPlayerView.delegate = self
    }

   private func playVimeoVideo(_ video: URL?) {
        
        DispatchQueue.main.async() {
            if let url = video {
                let player = AVPlayer(url: url)
                let playerController = AVPlayerViewController()
                playerController.view?.backgroundColor = .clear
                playerController.player = player
                self.present(playerController, animated: true) {
                    player.play()
                }
            }
            else {
                let alert = UIAlertController(title: "Error", message: "Invalid video URL", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func playYoutubeVideo(_ id: String) {
        
        videoController = VideoViewController.instantiate()
        
        if let vc = videoController {
            vc.videoId = id
            vc.view.frame = view.bounds
            vc.view.alpha = 0.1
            
            view.addSubview(vc.view)
            UIView.animate(withDuration: 0.3) {
                vc.view.alpha = 1
            }
        }
    }
    
    private func clearURLs() {
        model?.thumbnailURL = nil
        customView?.videoPlayerView.videoUrl = nil
    }
}

// MARK: - UniversalPlayerViewDelegate

extension UniversalPlayerViewController: UniversalPlayerViewDelegate {
    
    func youtubeAction() {
        let videoPath = Constants.YoutubeURL.trimmingCharacters(in: .whitespaces)
        
        customView?.videoPlayerView.videoUrl = URL(string: videoPath)
        model?.thumbnailURL = VideoManager().makeYoutubeThumbnail(from: videoPath)
    }
    
    func vimeoAction() {
        VideoManager().loadVimeoVideo(Constants.VimeoURL) { result in
            switch result {
            case .Error(let error):
                DispatchQueue.main.async() {
                    
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            case .Success(let videoUrl, let thumbnailUrl):
                self.customView?.videoPlayerView.videoUrl = videoUrl
                self.model?.thumbnailURL = thumbnailUrl
            }
        }
    }
}

// MARK: - UniversalPlayerModelDelegate

extension UniversalPlayerViewController: UniversalPlayerModelDelegate {
    func didReceiveThumbnailImage(_ image: UIImage?) {
        customView?.setThumbnail(image)
    }
}

extension UniversalPlayerViewController: VideoPlayerDelegate {
    
    func playVideo(withId: String) {
        clearURLs()
        playYoutubeVideo(withId)
    }
    
    func playVideo(_ video: URL?) {
        clearURLs()
        playVimeoVideo(video)
    }
}
