//
//  LaunchManager.swift
//  VK
//
//  Created by Рабочий on 14/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

protocol LaunchManager {
    func generateWindow() -> UIWindow
    func updateWindow(with controller: UIViewController)
}
