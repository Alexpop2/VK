//
//  ModulesManagerProtocol.swift
//  VK
//
//  Created by Рабочий on 08/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol ModulesManagerProtocol {
    func get(module: Modules)-> ControllerPackage?
}
