//
//  BaseViewController.swift
//  MaxASL
//
//  Created by Andrii Momot on 7/26/19.
//  Copyright © 2019 DBBest. All rights reserved.
//

import UIKit
import PKHUD

class BaseViewController: UIViewController {
    
    
    var tempView: NSObjectProtocol?
    var tempModel: NSObjectProtocol?
    
    init(withView view: NSObjectProtocol, model: NSObjectProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.tempView = view
        self.tempModel = model
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = tempView as? UIView
        tempView = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func setProgressVisible(visible:Bool) {
        if visible {
            HUD.show(.progress)
        } else {
            HUD.hide(animated: true)
        }
    }
}
