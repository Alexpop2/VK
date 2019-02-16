//
//  DatabaseService.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import KeychainAccess

class KeyValueStorage: KeyValueStorageInput {

    private let keychain = Keychain()
    
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
