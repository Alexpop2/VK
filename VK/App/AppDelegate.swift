//
//  AppDelegate.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var app: Application?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        VKSdk.forceLogout()
        window = UIWindow()
        let app = Application()
        window?.rootViewController = app.loadRootVC()
        window?.makeKeyAndVisible()
        self.app = app
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        VKSdk.processOpen(url, fromApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        
        return true
    }
}

