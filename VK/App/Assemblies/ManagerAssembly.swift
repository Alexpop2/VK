//
//  ManagerAssembly.swift
//  VK
//
//  Created by Рабочий on 15/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Swinject

final class ManagerAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(LaunchManager.self) { resolver in
            BaseLaunchManager(rootRouter: resolver.resolve(AuthorizationRouter.self)!)
            }.inObjectScope(.container)
    }
    
}
