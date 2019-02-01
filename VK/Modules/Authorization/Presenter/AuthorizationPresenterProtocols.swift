//
//  AuthorizationPresenterProtocols.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

protocol AuthorizationPresenterInput: class {
    var delegate: AuthorizationPresenterDelegate { get set }
    var view: AuthorizationViewInput { get set }
    var interactor: AuthorizationInteractorInput { get set }
}

protocol AuthorizationPresenterDelegate: class {
    func authorizationCompleted()
    func vkSdkShouldPresent(controller: UIViewController)
}
