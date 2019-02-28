//
//  InteractorsAssembly.swift
//  VK
//
//  Created by Рабочий on 28/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import Swinject

final class InteractorsAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AuthorizationInteractorInput.self) { resolver in
            AuthorizationInteractor(resolver: resolver)
            }.inObjectScope(.weak)
        container.register(NewsInteractorInput.self) { resolver in
            NewsInteractor(resolver: resolver)
            }.inObjectScope(.weak)
    }
    
}
