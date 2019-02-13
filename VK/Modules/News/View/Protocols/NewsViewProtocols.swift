//
//  NewsNewsViewProtocols.swift
//  VK
//
//  Created by Alexey Poponin on 07/02/2019.
//  Copyright © 2019 Aleksei Poponin. All rights reserved.
//

import Foundation

protocol NewsViewInput: class {
    var output: NewsViewOutput { get set }
    
    func display(newsItems: [NewsItem])
}

protocol NewsViewOutput: class {
    func viewDidLoad()
}
