//
//  NewsNewsViewProtocols.swift
//  VK
//
//  Created by Alexey Poponin on 07/02/2019.
//  Copyright © 2019 Aleksei Poponin. All rights reserved.
//

import Foundation
import UIKit

protocol NewsViewInput: class, AutoMockable {
    var controller: NewsViewController { get }
    var output: NewsViewOutput { get set }
    
    func display(sections: [NewsTableSection])
}

protocol NewsViewOutput: class, AutoMockable {
    func viewDidLoad()
    func textChanged(data: String)
    func audioPlayClicked(audioPacket: AudioPacket)
}
