//
//  ControllerPackageBuilder.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

//MARK: - Facade implementation

import Foundation
import UIKit

enum ViewControllers {
    case authorization
}

class ControllerPackageBuilder: ControllerPackageBuilderProtocol {
    
    private let database: DatabaseServiceInput = DatabaseService()
    private let modulesCoordinator : ModulesCoordinator
    
    private var viewControllers : [UIViewController] = []
    
    init(modulesCoordinator: ModulesCoordinator){
        self.modulesCoordinator = modulesCoordinator
    }
    
    func createPackage(type: ViewControllers )-> (ControllerPackageProtocol?){
        switch type {
        case .authorization:
            return createAuthorizationController()
        }
    }
}

extension ControllerPackageBuilder {
    private func createAuthorizationController()-> (ControllerPackageProtocol?){
        let assembly = AuthorizationAssembly()
        guard let auth = assembly.build(database: database) else {return nil}
        auth.presenter.delegate = modulesCoordinator
        return ControllerPackage(controller: auth.controller, presenter: auth.presenter)
    }
}

