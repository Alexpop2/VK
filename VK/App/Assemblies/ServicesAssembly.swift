//
//  ServicesAssembly.swift
//  VK
//
//  Created by Рабочий on 15/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

import Swinject

final class ServicesAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(InternetService.self) { resolver in
            InternetService()
            }.inObjectScope(.container)
        container.register(KeyValueStorage.self) { resolver in
            KeyValueStorage()
            }.inObjectScope(.transient)
        container.register(AuthorizationService.self) { resolver in
            AuthorizationService()
            }.inObjectScope(.transient)
        container.register(NewsfeedParser.self) { resolver in
            NewsfeedParser()
            }.inObjectScope(.transient)
        container.register(AudioService.self) { resolver in
            AudioService()
            }.inObjectScope(.container)
    }
    
}
