//
//  ApplicationProtocols.swift
//  VK
//
//  Created by Рабочий on 08/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

protocol ApplicationDelegate: class {
    func present(controller: UIViewController?)
}

protocol AppDelegateOutput: class {
    func present(controller: UIViewController?)
}
