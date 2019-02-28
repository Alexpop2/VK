//
//  BaseAuthorizationRouter.swift
//  VK
//
//  Created by Рабочий on 14/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import UIKit
import Swinject

final class BaseAuthorizationRouter {
    
    // MARK: - Private properties
    
    private let resolver: Resolver
    private weak var rootViewController: AuthorizationViewController?
    
    // MARK: - Initialization
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
}

// MARK: - protocol implementation

extension BaseAuthorizationRouter: AuthorizationRouter {
    func getConfiguredRootViewController() -> UIViewController {
        guard let viewController = resolver.resolve(AuthorizationViewInput.self) else {
            return UIViewController()
        }
        //let authService = resolver.resolve(AuthorizationService.self)!
        let presenter = resolver.resolve(AuthorizationPresenterInput.self)!
        //let interactor = resolver.resolve(AuthorizationInteractorInput.self)!
        //let keyValueStorage = resolver.resolve(KeyValueStorage.self)!
        
        //viewController.output = presenter
        //presenter.interactor = interactor
        //presenter.view = viewController
        //interactor.output = presenter
        
        //interactor.authService = authService
        //authService.output = interactor
        //interactor.keyValueStorage = keyValueStorage
        let _ = presenter.view
        
        presenter.delegate = self
        
        rootViewController = viewController.controller
        return viewController.controller
        
    }
    
    func route(to: AuthorizationRoute) {
        switch to {
        case .news:
            let newsRouter = resolver.resolve(NewsRouter.self)!
            let launchManager = resolver.resolve(LaunchManager.self)!
            launchManager.updateWindow(with: newsRouter.getConfiguredRootViewController())
        }
    }
}

extension BaseAuthorizationRouter: AuthorizationPresenterDelegate {
    func authorizationCompleted() {
        route(to: .news)
    }
}
