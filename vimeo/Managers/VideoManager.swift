//
//  VimeoManager.swift
//  vimeo
//
//  Created by Andrii Momot on 7/30/19.
//  Copyright © 2019 Andrii Momot. All rights reserved.
//

import Foundation
import HCVimeoVideoExtractor
import AVKit

enum Result <T, V>{
    case Success(T, V)
    case Error(Error)
}

typealias ManagerResult = (Result<URL?, URL?>) -> Void

class VideoManager: NSObject {
    
    func loadVimeoVideo(_ urlString: String, completion: @escaping ManagerResult) {
        if let url = URL(string: urlString) {
            HCVimeoVideoExtractor.fetchVideoURLFrom(url: url, completion: { (video: HCVimeoVideo?, error: Error?) -> Void in
                
                if let err = error {
                    
                    print("Error = \(err.localizedDescription)")
                    completion(Result.Error(err))
                    return
                }
                
                guard let vid = video else {
                    print("Invalid video object")
                    return
                }
                
                print("Title = \(vid.title), url = \(vid.videoURL), thumbnail = \(vid.thumbnailURL)")
                
                let videoUrl = vid.videoURL[.Quality720p]
                let thumbnailURL = vid.thumbnailURL[.Quality640]
                completion(Result.Success(videoUrl, thumbnailURL))
            })
        }
    }
    
    func makeYoutubeThumbnail(from videoPath: String) -> URL? {
        var thumbnailURL: URL?
        if let id = videoPath.split(separator: "?").last?.split(separator: "=").last {
            thumbnailURL = URL(string: "https://img.youtube.com/vi/\(id)/0.jpg")
        }
        if videoPath.contains("youtu.be") == true, let id = videoPath.split(separator: "/").last {
            thumbnailURL = URL(string: "https://img.youtube.com/vi/\(id)/0.jpg")
        }
        return thumbnailURL
    }
}
