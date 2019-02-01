//
//  ControllerPackageProtocol.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

protocol ControllerPackageProtocol: class{
    var controller: UIViewController {get set}
    var presenter: MainPresenter {get set}
}
