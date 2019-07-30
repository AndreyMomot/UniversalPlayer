//
//  AppDelegate.swift
//  vimeo
//
//  Created by Andrii Momot on 3/27/19.
//  Copyright © 2019 Andrii Momot. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupRootVC()

        return true
    }
    
    func setupRootVC() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let vc = UniversalPlayerBuilder.viewController()
        window?.rootViewController = BaseNavigationController(rootViewController: vc)
    }
}

