//
//  InternetService.swift
//  VK
//
//  Created by Рабочий on 08/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

class InternetService { //VKInternetService
}

extension InternetService: InternetServiceInput {
    func loadData<T>(fromURL: URL?,
                     parseInto container: T.Type,
                     queue: OperationQueue,
                     success: @escaping (T) -> Void,
                     failure: @escaping (Int) -> Void) where T : Codable {
        guard let url = fromURL else {
            failure(102)
            return
        }
        queue.cancelAllOperations()
        queue.addOperation(LoadDataOperation(completion: { (data) in
            self.parse(data: data,
                       container: container,
                       success: success,
                       failure: failure)
        }, failure: { (code) in
            failure(102)
        }, url: url))
    }
}

extension InternetService {
    private func parse<T>(data: Data,
                          container: T.Type,
                          success: @escaping (T) -> Void,
                          failure: (Int) -> Void) where T : Codable {
        do {
            let response = try JSONDecoder().decode(container, from: data)
            DispatchQueue.main.async {
                success(response)
            }
        } catch {
            //print("error.\(error.localizedDescription)")
            print(error)
            failure(102)
        }
    }
}
