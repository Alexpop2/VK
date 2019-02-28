//
//  AuthorizationPresenter.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class AuthorizationPresenter {
    private let resolver: Resolver
    
    private weak var presenterDelegate: AuthorizationPresenterDelegate!
    private lazy var authInteractor: AuthorizationInteractorInput! = {
        var interactorLazy = self.resolver.resolve(AuthorizationInteractorInput.self)!
        interactorLazy.output = self
        return interactorLazy
    }()
    private lazy var authView: AuthorizationViewInput! = {
        var viewInputLazy = self.resolver.resolve(AuthorizationViewInput.self)!
        viewInputLazy.output = self
        return viewInputLazy
    }()
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
}

extension AuthorizationPresenter: AuthorizationPresenterInput {
    var delegate: AuthorizationPresenterDelegate {
        get {
            return presenterDelegate
        }
        set {
            presenterDelegate = newValue
        }
    }
    
    var view: AuthorizationViewInput {
        get {
            return authView
        }
        set {
            authView = newValue
        }
    }
    
    var interactor: AuthorizationInteractorInput {
        get {
            return authInteractor
        }
        set {
            authInteractor = newValue
        }
    }
}

extension AuthorizationPresenter: AuthorizationInteractorOutput {
    func authorizationCompleted() {
        delegate.authorizationCompleted()
    }
    
    func authorizationFailed(withError error: Error) {
        print(error)
    }
    
    func presentAuthorizationScreen(data: AuthorizationData) {
        view.showAuthScreen(data: data)
    }
}

extension AuthorizationPresenter: AuthorizationViewOutput {
    func viewDidAppear() {
        interactor.authorize()
    }
}
