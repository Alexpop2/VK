//
//  AuthorizationInteractorProtocols.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol AuthorizationInteractorInput: class, AutoMockable {
    var output: AuthorizationInteractorOutput { get set }
    func authorize()
}

protocol AuthorizationInteractorOutput: class, AutoMockable {
    func authorizationCompleted()
    func authorizationFailed(withError error: Error)
    func presentAuthorizationScreen(data: AuthorizationData)
}

protocol RoutingAuthorizationView: class, AutoMockable {
    func presentAuthorizationView()
}
