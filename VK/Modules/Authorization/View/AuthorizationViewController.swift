//
//  AuthorizationViewController.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import UIKit
import VK_ios_sdk

class AuthorizationViewController: UIViewController {

    private var viewOutput: AuthorizationViewOutput!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        output.viewDidAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension AuthorizationViewController: AuthorizationViewInput {
    var controller: AuthorizationViewController {
        return self
    }
    
    var output: AuthorizationViewOutput {
        get {
            return viewOutput
        }
        set {
            viewOutput = newValue
        }
    }
    
    func showAuthScreen(data: AuthorizationData) {
        present(data.authorizationViewController, animated: true)
    }
}
