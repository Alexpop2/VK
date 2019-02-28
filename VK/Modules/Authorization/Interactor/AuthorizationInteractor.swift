//
//  AuthorizationInteractor.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import Swinject

class AuthorizationInteractor {
    private let resolver: Resolver
    
    private var interactorOutput: AuthorizationInteractorOutput!
    
    private lazy var keyValueStorage: KeyValueStorageInput! = {
        var storageLazy = self.resolver.resolve(KeyValueStorageInput.self)!
        return storageLazy
    }()
    
    private lazy var authService: AuthorizationServiceInput! = {
        var authServiceLazy = self.resolver.resolve(AuthorizationServiceInput.self)!
        authServiceLazy.output = self
        return authServiceLazy
    }()
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
}

extension AuthorizationInteractor: AuthorizationInteractorInput {
    
    var output: AuthorizationInteractorOutput {
        get {
            return interactorOutput
        }
        set {
            interactorOutput = newValue
        }
    }
    
    func authorize() {
        authService.authorize()
    }
    
}

extension AuthorizationInteractor: AuthorizationServiceOutput {
    
    func recieved(token: String) {
        keyValueStorage.deleteValue(byKey: "vk-token")
        keyValueStorage.addValue(forKey: "vk-token", data: token)
    }
    
    func authorizationCompleted() {
        interactorOutput.authorizationCompleted()
    }
    
    func authorizationFailed(withError error: Error) {
        interactorOutput.authorizationFailed(withError: error)
    }
    
    func presentAuthorizationScreen(data: AuthorizationData) {
        interactorOutput.presentAuthorizationScreen(data: data)
    }
}

extension AuthorizationInteractor: KeyValueStorageOutput {}
