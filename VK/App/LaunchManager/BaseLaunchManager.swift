//
//  BaseLaunchManager.swift
//  VK
//
//  Created by Рабочий on 14/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

final class BaseLaunchManager {
    
    private var rootRouter: AuthorizationRouter
    
    private var window: UIWindow!
    
    init(rootRouter: AuthorizationRouter) {
        self.rootRouter = rootRouter
    }
    
}

extension BaseLaunchManager: LaunchManager {
    func generateWindow() -> UIWindow {
        let window = UIWindow()
        window.rootViewController = rootRouter.getConfiguredRootViewController()
        window.makeKeyAndVisible()
        self.window = window
        return window
    }
    
    func updateWindow(with controller: UIViewController) {
        window.rootViewController = controller
    }
}
