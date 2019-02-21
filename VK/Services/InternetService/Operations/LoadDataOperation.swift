//
//  LoadDataOperation.swift
//  VK
//
//  Created by Рабочий on 21/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

class LoadDataOperation: Operation {
    private let completion: (Data) -> Void
    private let failure: (Int) -> Void
    private var dataTask: URLSessionDataTask?
    private let url: URL
    
    init(completion: @escaping (Data) -> Void, failure: @escaping (Int) -> Void, url: URL) {
        self.completion = completion
        self.failure = failure
        self.url = url
        super.init()
    }
    
    override func main() {
        let semaphore = DispatchSemaphore(value: 0)
        dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if !self.isCancelled {
                if data != nil {
                    self.completion(data!)
                } else {
                    self.failure(102)
                }
            } else {
                print("Canceled")
            }
            
            semaphore.signal()
        })
        dataTask?.resume()
        _ = semaphore.wait(timeout: .distantFuture)
    }
    
    override func cancel() {
        super.cancel()
        dataTask?.cancel()
    }
}
