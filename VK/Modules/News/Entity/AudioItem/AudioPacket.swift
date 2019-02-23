//
//  AudioPacket.swift
//  VK
//
//  Created by Рабочий on 23/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

struct AudioPacket {
    var ownerId: Int
    var audioId: Int
    var title: String
    var artist: String
    var stopClosure: (() -> Void)
    var setProgressClosure: ((Float,Bool) -> Void)
    var playClosure: (() -> Void)
}
