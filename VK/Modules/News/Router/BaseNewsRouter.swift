//
//  BaseNewsRouter.swift
//  VK
//
//  Created by Рабочий on 15/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import UIKit
import Swinject

final class BaseNewsRouter {
    
    // MARK: - Private properties
    
    private let resolver: Resolver
    private weak var rootViewController: NewsViewController?
    
    // MARK: - Initialization
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
}

// MARK: - protocol implementation

extension BaseNewsRouter: NewsRouter {
    func getConfiguredRootViewController() -> UIViewController {
        guard let viewController = resolver.resolve(NewsViewInput.self) else {
            return UIViewController()
        }

        let presenter = resolver.resolve(NewsPresenterInput.self)!
        //let interactor = resolver.resolve(NewsInteractorInput.self)!
//        let keyValueStorage = resolver.resolve(KeyValueStorage.self)!
//        let internetService = resolver.resolve(InternetService.self)!
//        let newsfeedParser = resolver.resolve(NewsfeedParser.self)!
//        let audioService = resolver.resolve(AudioService.self)!
//        audioService.internetService = internetService
        
        //viewController.output = presenter
        //presenter.interactor = interactor
        //presenter.view = viewController
        //interactor.output = presenter
        
//        interactor.keyValueStorage = keyValueStorage
//        interactor.internetService = internetService
//        interactor.newsfeedParser = newsfeedParser
//        interactor.audioSerice = audioService
        
        let _ = presenter.view
        
        presenter.delegate = self
        
        rootViewController = viewController.controller
        return viewController.controller
        
    }
    
    func route(to: NewsRoute) {
        switch to {
        case .authorization:
            let authorizationRouter = resolver.resolve(AuthorizationRouter.self)!
            let launchManager = resolver.resolve(LaunchManager.self)!
            launchManager.updateWindow(with: authorizationRouter.getConfiguredRootViewController())
        }
    }
}

extension BaseNewsRouter: NewsPresenterDelegate {
    func authorizationRequired() {
        route(to: .authorization)
    }
}
