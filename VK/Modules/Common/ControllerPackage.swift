//
//  ControllerPackage.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

class ControllerPackage : ControllerPackageProtocol{
    var controller: UIViewController
    var presenter: Presentable
    
    init(controller:UIViewController, presenter: Presentable){
        self.controller = controller
        self.presenter = presenter
    }
}
