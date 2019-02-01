//
//  AuthorizationInteractorProtocols.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol AuthorizationInteractorInput: class {
    var output: AuthorizationInteractorOutput { get set }
    func authorize()
}

protocol AuthorizationInteractorOutput: class {
    func authorizationCompleted()
    func authorizationFailed(withError error: Error)
    func exceptionRose(data: AuthorizationData)
}
