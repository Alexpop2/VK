//
//  RoutersAssembly.swift
//  VK
//
//  Created by Рабочий on 15/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Swinject

final class RoutersAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AuthorizationRouter.self) { resolver in
            BaseAuthorizationRouter(resolver: resolver)
            }.inObjectScope(.container)
        container.register(NewsRouter.self) { resolver in
            BaseNewsRouter(resolver: resolver)
            }.inObjectScope(.container)
    }
    
}
