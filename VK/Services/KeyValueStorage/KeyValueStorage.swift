//
//  DatabaseService.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import KeychainAccess

// MARK: - Storage for keys

class KeyValueStorage {
    private let keychain = Keychain()
    private var storageOutput: KeyValueStorageOutput!
}

extension KeyValueStorage: KeyValueStorageInput {
    
    func addValue(forKey: String, data: String) { //называть не token а addValueForKey и т.п.
        keychain[forKey] = data
    }
    
    func loadValue(byKey: String, loaded: (String?) -> Void) {
        loaded(keychain[byKey])
    }
    
    func deleteValue(byKey: String) {
        keychain[byKey] = nil
    }
}
