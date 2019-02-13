//
//  AppDelegate.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import UIKit
import VK_ios_sdk
import Swinject
import KeychainAccess

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var app: Application?
    
    //Манагера сюда перенести
    
    //список ассамблей в массиве Assembly
    
    //конфигуратор 
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        VKSdk.forceLogout()
        
        window = UIWindow()
        let app = Application()
        app.delegate = self
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

extension AppDelegate: AppDelegateOutput {
    func present(controller: UIViewController?) {
        window?.rootViewController = controller
    }
}
