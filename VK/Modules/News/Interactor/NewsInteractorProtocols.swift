//
//  NewsNewsInteractorProtocols.swift
//  VK
//
//  Created by Alexey Poponin on 07/02/2019.
//  Copyright © 2019 Aleksei Poponin. All rights reserved.
//

import Foundation

protocol NewsInteractorInput: class {
    var output: NewsInteractorOutput { get set }
}

protocol NewsInteractorOutput: class {
}
