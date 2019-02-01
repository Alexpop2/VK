//
//  AuthorizationService.swift
//  VK
//
//  Created by Рабочий on 26/01/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import VK_ios_sdk

class AuthorizationService {
    private var authServiceOutput: AuthorizationServiceOutput!
    private var data: AuthorizationData?
    private var sdkInstance: VKSdk?
    
    init(controller: AuthorizationViewController) {
        sdkInstance = VKSdk.initialize(withAppId: "6842964")
        sdkInstance?.register(controller)
        sdkInstance?.uiDelegate = controller
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
        let permissions = ["friends", "email"]
        
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
