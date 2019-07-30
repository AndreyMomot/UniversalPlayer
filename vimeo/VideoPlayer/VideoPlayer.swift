//
//  VideoPlayer.swift


import UIKit
import AVFoundation
import youtube_ios_player_helper

protocol VideoPlayerDelegate: NSObjectProtocol {
    
    func playVideo(_ video: URL?)
    func playVideo(withId: String)
}

class VideoPlayer: UIView {
    
    weak var delegate: VideoPlayerDelegate?
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBAction func playButtonAction(_ sender: Any) {
        
        let urlString = videoUrl?.absoluteString
        if urlString?.contains("vimeo") == true {
            delegate?.playVideo(videoUrl)
        } else if urlString?.contains("youtu") == true {
            let query = urlString?.split(separator: "?")
            var id = query?.last?.split(separator: "=").last
            
            if urlString?.contains("youtu.be") == true {
                id = urlString?.split(separator: "/").last
            }
            
            delegate?.playVideo(withId: String(id ?? ""))
        }
    }
    
    var videoUrl: URL?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addContentFromNib(named: "\(type(of: self))")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addContentFromNib(named: "\(type(of: self))")
    }
}


