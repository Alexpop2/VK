//
//  Application.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class Application {
    private let modulesCoordinator: ModulesCoordinator
    
    weak var delegate: AppDelegateOutput!
    
    init() {
        modulesCoordinator = ModulesCoordinator()
        modulesCoordinator.delegate = self
    }
}

extension Application {
    func loadRootVC() -> UIViewController {
        return modulesCoordinator.rootModuleController()
    }
}

extension Application: ApplicationDelegate {
    func present(controller: UIViewController?) {
        delegate.present(controller: controller)
    }
}
