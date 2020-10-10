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
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.isTranslucent = true
    }

}

