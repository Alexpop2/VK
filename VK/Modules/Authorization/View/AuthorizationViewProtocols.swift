//
//  AuthorizationViewProtocols.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

protocol AuthorizationViewInput: class {
    var output: AuthorizationViewOutput { get set }
}

protocol AuthorizationViewOutput: class {
    func viewDidAppear()
    func vkSdkShouldPresent(controller: UIViewController)
    func authCompletedWith(token: String)
}
