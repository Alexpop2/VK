//
//  NewsNewsRouter.swift
//  VK
//
//  Created by Alexey Poponin on 07/02/2019.
//  Copyright © 2019 Aleksei Poponin. All rights reserved.
//

import Foundation
import UIKit

// MARK: - enum for segue screens

enum NewsRoute {
    case authorization
}

// MARK: - Auth Router protocol

protocol NewsRouter: AutoMockable {
    
    func getConfiguredRootViewController() -> UIViewController
    func route(to: NewsRoute)
    
}
