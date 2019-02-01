//
//  AuthorizationInteractor.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

class AuthorizationInteractor {
    private var interactorOutput: AuthorizationInteractorOutput!
    
    var database: DatabaseServiceInput!
    var authService: AuthorizationService!
}

extension AuthorizationInteractor: AuthorizationInteractorInput {
    func recieved(token: String) {
        database.deleteToken()
        database.add(token: token)
    }
    
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
    func authorizationCompleted() {
        interactorOutput.authorizationCompleted()
    }
    
    func authorizationFailed(withError error: Error) {
        interactorOutput.authorizationFailed(withError: error)
    }
    
    func exceptionRose(data: AuthorizationData) {
        interactorOutput.exceptionRose(data: data)
    }
}
