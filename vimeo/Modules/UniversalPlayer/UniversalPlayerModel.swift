//
//  UniversalPlayerModel.swift
//  vimeo
//
//  Created by Andrii Momot on 3/28/19.
//  Copyright © 2019 Andrii Momot. All rights reserved.
//

import UIKit

protocol UniversalPlayerModelDelegate: NSObjectProtocol {
    func didReceiveThumbnailImage(_ image: UIImage?)
}

protocol UniversalPlayerModelProtocol: NSObjectProtocol {
    
    var delegate: UniversalPlayerModelDelegate? { get set }
    var thumbnailURL: URL? { get set }
}

class UniversalPlayerModel: NSObject, UniversalPlayerModelProtocol {
    
    // MARK: - UniversalPlayerModel methods

    weak public var delegate: UniversalPlayerModelDelegate?
    
    var thumbnailURL: URL? {
        didSet {
            DispatchQueue.main.async() {
                guard let url = self.thumbnailURL else { return }
                if let data = try? Data(contentsOf: url) {
                    self.delegate?.didReceiveThumbnailImage(UIImage(data: data))
                }
            }
        }
    }
}
