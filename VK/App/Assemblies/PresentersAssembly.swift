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
        container.register(AuthorizationPresenter.self) { resolver in
            AuthorizationPresenter()
            }.inObjectScope(.weak)
        container.register(NewsPresenter.self) { resolver in
            NewsPresenter()
            }.inObjectScope(.weak)
    }
    
}
