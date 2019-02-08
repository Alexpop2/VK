//
//  DatabaseService.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import KeychainAccess

class DatabaseService: DatabaseServiceInput {
    let keychain = Keychain(service: "com.vk-token")
    
    func loadToken() -> String? {
        return keychain["vk-token"]
    }
    
    func add(token: String) {
        keychain["vk-token"] = token
    }
    
    func deleteToken() {
        keychain["vk-token"] = nil
    }
}
