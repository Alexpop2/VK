//
//  InternetServiceProtocols.swift
//  VK
//
//  Created by Рабочий on 08/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol InternetServiceInput: class { //InternetService
    func loadData<T>(fromURL: URL?,
                     parseInto container: T.Type,
                     success: @escaping (T) -> Void,
                     failure: @escaping (Int) -> Void) where T : Codable
}
