//
//  AppDelegate.swift
//  MovieShowcase
//
//  Created by Pratik on 10/10/20.
//  Copyright © 2020 Pratik Lad. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        navigationBarSettiongs()
        return true
    }
    private func navigationBarSettiongs() {
        let appearance = UINavigationBar.appearance()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        appearance.isTranslucent = true
        appearance.tintColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        appearance.barTintColor = #colorLiteral(red: 0.1333333333, green: 0.1529411765, blue: 0.1803921569, alpha: 1)
        appearance.shadowImage = UIImage()
    }

}

