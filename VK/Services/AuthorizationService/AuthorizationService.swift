//
//  AuthorizationService.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import VK_ios_sdk

class AuthorizationService: NSObject {
    private var authServiceOutput: AuthorizationServiceOutput!
    private var data: AuthorizationData?
    private var sdkInstance: VKSdk?
    
    override init() {
        super.init()
        sdkInstance = VKSdk.initialize(withAppId: "6842964")
        sdkInstance?.register(self)
        sdkInstance?.uiDelegate = self
    }
}

extension AuthorizationService: AuthorizationServiceInput {
    var output: AuthorizationServiceOutput {
        get {
            return authServiceOutput
        }
        set {
            authServiceOutput = newValue
        }
    }
    
    func authorize() {
        let permissions = ["friends", "email", "photos", "wall", "video", "audio", "docs"] // было friend, email, photo
        
        VKSdk.wakeUpSession(permissions) { (state, error) in
            if (state == VKAuthorizationState.authorized) {
                self.output.authorizationCompleted()
            } else if(state == VKAuthorizationState.initialized) {
                VKSdk.authorize(permissions)
            } else if ((error) != nil) {
                self.output.authorizationFailed(withError: error!)
            }
        }
    }
}

extension AuthorizationService: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        guard let token = result.token.accessToken else { return }
        output.recieved(token: token)
    }
    
    func vkSdkUserAuthorizationFailed() {
        // TODO: realise
        
        print("controller auth failed")
    }
}

extension AuthorizationService: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        output.presentAuthorizationScreen(data: AuthorizationData(authorizationViewController: controller))
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("captcha error")
    }
}
