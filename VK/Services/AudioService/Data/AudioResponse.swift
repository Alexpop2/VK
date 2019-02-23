//
//  AudioResponse.swift
//  VK
//
//  Created by Рабочий on 23/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

struct AudioData: Codable {
    var response: [AudioResponse]
}

struct AudioResponse: Codable {
    var duration: Int?
    var url: String?
}
