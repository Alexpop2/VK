//
//  DatabaseProtocols.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol KeyValueStorageInput {
    func loadValue(byKey: String, loaded: (String?) -> Void)
    func addValue(forKey: String, data: String)
    func deleteValue(byKey: String)
}

protocol KeyValueStorageOutput {}
