//
//  PresentersAssembly.swift
//  VK
//
//  Created by Рабочий on 15/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

import Swinject

final class PresentersAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AuthorizationPresenterInput.self) { resolver in
            AuthorizationPresenter(resolver: resolver)
            }.inObjectScope(.weak)
        container.register(NewsPresenterInput.self) { resolver in
            NewsPresenter(resolver: resolver)
            }.inObjectScope(.weak)
    }
    
}
