//
//  ModulesManager.swift
//  VK
//
//  Created by Рабочий on 08/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class ModulesManager {
    
    private let database: DatabaseServiceInput = DatabaseService()
    weak var modulesCoordinator : ModulesCoordinator!
    
    let container: Container
    
    init() {
        let container = Container()
        self.container = container
    }
    
    func registerModules() {
        container.register(ControllerPackage?.self, name: Modules.auth.rawValue, factory: { _ in
            let assembly = AuthorizationAssembly()
            guard let auth = assembly.build(database: self.database) else { return nil }
            auth.presenter.delegate = self.modulesCoordinator
            return ControllerPackage(controller: auth.controller, presenter: auth.presenter)
        })
        container.register(ControllerPackage?.self, name: Modules.news.rawValue, factory: { _ in
            let assembly = NewsAssembly()
            guard let auth = assembly.build() else { return nil }
            auth.presenter.delegate = self.modulesCoordinator
            return ControllerPackage(controller: auth.controller, presenter: auth.presenter)
        })
    }
    
}

extension ModulesManager: ModulesManagerProtocol {
    
    func get(module: Modules)-> ControllerPackage? {
        return container.resolve(ControllerPackage?.self, name: module.rawValue) ?? nil
    }
    
}
