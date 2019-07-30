//
//  UniversalPlayerBuilder.swift
//  vimeo
//
//  Created by Andrii Momot on 3/28/19.
//  Copyright © 2019 Andrii Momot. All rights reserved.
//

import Foundation

class UniversalPlayerBuilder {

    class func viewController() -> UniversalPlayerViewController {

        let view: UniversalPlayerViewProtocol = UniversalPlayerView.create() as  UniversalPlayerViewProtocol
        let model: UniversalPlayerModelProtocol = UniversalPlayerModel()
        
        let viewController = UniversalPlayerViewController(withView: view, model: model)
        return viewController
    }
}
