//
//  ViewAssembly.swift
//  VK
//
//  Created by Рабочий on 28/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import Swinject

final class ViewsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AuthorizationViewInput.self) { resolver in
            AuthorizationViewController.instantiateFromStoryboard(with: .authorization)!
            }.inObjectScope(.weak)
        container.register(NewsViewInput.self) { resolver in
            NewsViewController.instantiateFromStoryboard(with: .news)!
            }.inObjectScope(.weak)
    }
    
}
