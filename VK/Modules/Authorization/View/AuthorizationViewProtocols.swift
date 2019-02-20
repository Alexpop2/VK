//
//  AuthorizationViewProtocols.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

protocol AuthorizationViewInput: class, AutoMockable {
    var output: AuthorizationViewOutput { get set }
    
    func showAuthScreen(data: AuthorizationData)
}

protocol AuthorizationViewOutput: class, AutoMockable {
    func viewDidAppear()
}
