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
    var output: AuthorizationViewOutput {
        get {
            return viewOutput
        }
        set {
            viewOutput = newValue
        }
    }
    
    
}

extension AuthorizationViewController: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        guard let token = result.token.accessToken else { return }
        output.authCompletedWith(token: token)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("controller auth failed")
    }
}

extension AuthorizationViewController: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        output.vkSdkShouldPresent(controller: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("captcha error")
    }
}
