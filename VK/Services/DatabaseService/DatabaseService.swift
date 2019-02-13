//
//  DatabaseService.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import KeychainAccess

class DatabaseService: DatabaseServiceInput { //KeyValueStorage
    private let keychain = Keychain()
    
    func loadToken() -> String? {
        return keychain["vk-token"]
    }
    
    func add(token: String) { //называть не token а addValueForKey и т.п.
        keychain["vk-token"] = token
    }
    
    func deleteToken() {
        keychain["vk-token"] = nil
    }
}
