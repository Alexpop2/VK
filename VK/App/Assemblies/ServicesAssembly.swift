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
        container.register(InternetServiceInput.self) { resolver in
            InternetService()
            }.inObjectScope(.container)
        container.register(KeyValueStorageInput.self) { resolver in
            KeyValueStorage()
            }.inObjectScope(.transient)
        container.register(AuthorizationServiceInput.self) { resolver in
            AuthorizationService()
            }.inObjectScope(.transient)
        container.register(NewsfeedParserInput.self) { resolver in
            NewsfeedParser()
            }.inObjectScope(.transient)
        container.register(AudioServiceInput.self) { resolver in
            AudioService(resolver: resolver)
            }.inObjectScope(.container)
    }
    
}
