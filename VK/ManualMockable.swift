//
//  ManualMockable.swift
//  VK
//
//  Created by Рабочий on 19/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

class KeyValueStorageInputManualMock: KeyValueStorageInput {
    func loadValue(byKey: String, loaded: (String?) -> Void) {
        loaded("mock-token")
    }
    
    func addValue(forKey: String, data: String) {
        return
    }
    
    func deleteValue(byKey: String) {
        return
    }
    
    
}

class InternetServiceInputManualMock: InternetServiceInput {
    func loadData<T>(fromURL: URL?,
                     parseInto container: T.Type,
                     success: @escaping (T) -> Void,
                     failure: @escaping (Int) -> Void) where T : Decodable, T : Encodable {
        guard let asset = NSDataAsset(name: "newsfeed_test") else { return }
        do {
            let response = try JSONDecoder().decode(container, from: asset.data)
            DispatchQueue.main.async {
                success(response)
            }
        } catch {
            print("error.\(error.localizedDescription)")
            failure(102)
        }
    }
    
    
}
