//
//  AppDelegate.swift
//  Drawer
//
//  Created by YanYi on 2020/2/23.
//  Copyright © 2020 YanYi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController.init(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()
        return true
    }



}

