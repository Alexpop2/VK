//
//  AuthorizationRouter.swift
//  VK
//
//  Created by Рабочий on 14/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

// MARK: - enum for segue screens

enum AuthorizationRoute {
    case news
}

// MARK: - Auth Router protocol

protocol AuthorizationRouter: AutoMockable {
    
    func getConfiguredRootViewController() -> UIViewController
    func route(to: AuthorizationRoute)
    
}
