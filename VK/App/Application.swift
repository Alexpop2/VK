//
//  Application.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

class Application {
    private let modulesCoordinator: ModulesCoordinator
    
    init() {
        modulesCoordinator = ModulesCoordinator()
    }
}

extension Application {
    func loadRootVC() -> UIViewController {
        return modulesCoordinator.rootModuleController()
    }
}
