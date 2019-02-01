//
//  AuthorizationPresenter.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationPresenter {
    private weak var presenterDelegate: AuthorizationPresenterDelegate!
    private var authInteractor: AuthorizationInteractorInput!
    private weak var authView: AuthorizationViewInput!
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
    
    func exceptionRose(data: AuthorizationData) {
        // TODO: - Safari Auth
    }
}

extension AuthorizationPresenter: AuthorizationViewOutput {
    func authCompletedWith(token: String) {
        interactor.recieved(token: token)
    }
    
    func vkSdkShouldPresent(controller: UIViewController) {
        delegate.vkSdkShouldPresent(controller: controller)
    }
    
    func viewDidAppear() {
        interactor.authorize()
    }
}

extension AuthorizationPresenter: MainPresenter {}
