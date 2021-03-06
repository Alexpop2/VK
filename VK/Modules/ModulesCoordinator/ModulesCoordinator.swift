//
//  ModulesCoordinator.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit
import VK_ios_sdk
import Swinject

enum Modules: String {
    case auth = "Authorization"
    case news = "News"
}

//данные нужно кидать через ассамблеи через умный енум

class ModulesCoordinator {
    
    private var modulesManager: ModulesManagerProtocol // протокол пиздец
    
    weak var delegate: ApplicationDelegate!
    
    init() {
        let modulesManager = ModulesManager()
        modulesManager.registerModules()
        self.modulesManager = modulesManager
        modulesManager.modulesCoordinator = self
    }
    
    func rootModuleController() -> UIViewController {
        guard let authPackage = modulesManager.get(module: .auth) else { return UIViewController() }
        return authPackage.controller
    }
    
}

extension ModulesCoordinator: AuthorizationPresenterDelegate {
    
    func authorizationCompleted() {
        guard let newsPackage = modulesManager.get(module: .news) else { return }
        delegate.present(controller: newsPackage.controller)
    }
    
}

extension ModulesCoordinator: NewsPresenterDelegate {
    func authorizationRequired() {
        VKSdk.forceLogout()
        guard let authPackage = modulesManager.get(module: .auth) else { return }
        delegate.present(controller: authPackage.controller)
    }
    
    
}
