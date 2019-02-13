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

class ModulesManager { //MainDependenceProvider
    
    private let database: DatabaseServiceInput = DatabaseService() // передавать сюда а не создавать
    private let internetService: InternetServiceInput = InternetService() // передавать сюда а не создавать
    weak var modulesCoordinator: ModulesCoordinator!
    
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
        }).inObjectScope(.container)
        container.register(ControllerPackage?.self, name: Modules.news.rawValue, factory: { _ in
            let assembly = NewsAssembly()
            guard let auth = assembly.build(database: self.database, internetService: self.internetService) else { return nil }
            auth.presenter.delegate = self.modulesCoordinator
            return ControllerPackage(controller: auth.controller, presenter: auth.presenter)
        }).inObjectScope(.container)
    }
    
}

extension ModulesManager: ModulesManagerProtocol {
    
    func get(module: Modules)-> ControllerPackage? {
        return container.resolve(ControllerPackage?.self, name: module.rawValue) ?? nil
    }
    
}
