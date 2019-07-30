//
//  UniversalPlayerView.swift
//  vimeo
//
//  Created by Andrii Momot on 3/28/19.
//  Copyright © 2019 Andrii Momot. All rights reserved.
//

import UIKit

protocol UniversalPlayerViewDelegate: NSObjectProtocol {
    func youtubeAction()
    func vimeoAction()
}

protocol UniversalPlayerViewProtocol: NSObjectProtocol {
    
    var delegate: UniversalPlayerViewDelegate? { get set }
    var videoPlayerView: VideoPlayer! { get }
    func setThumbnail(_ image: UIImage?)
}

class UniversalPlayerView: UIView, UniversalPlayerViewProtocol{
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var videoPlayerView: VideoPlayer!
    
    // MARK: - UniversalPlayerView interface methods

    weak public var delegate: UniversalPlayerViewDelegate?
    
    func setThumbnail(_ image: UIImage?) {
        thumbnailImageView.image = image
    }
    
    // MARK: - Overrided methods

    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - IBActions
    
    @IBAction func youtubeButtonAction(_ sender: Any) {
        delegate?.youtubeAction()
    }
    
    @IBAction func vimeoButtonAction(_ sender: Any) {
        delegate?.vimeoAction()
    }
}
