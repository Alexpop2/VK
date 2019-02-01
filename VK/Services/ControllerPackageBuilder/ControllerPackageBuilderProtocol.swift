//
//  ControllerPackageBuilderProtocol.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol ControllerPackageBuilderProtocol: class {
    func createPackage(type: ViewControllers )->(ControllerPackageProtocol?)
}
