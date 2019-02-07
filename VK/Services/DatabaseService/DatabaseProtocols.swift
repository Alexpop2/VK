//
//  DatabaseProtocols.swift
//  VK
//
//  Created by Рабочий on 01/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol DatabaseServiceInput {
    func loadToken() -> String?
    func add(token: String)
    func deleteToken()
}
