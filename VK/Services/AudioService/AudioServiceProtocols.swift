//
//  AudioService.swift
//  VK
//
//  Created by Рабочий on 23/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol AudioServiceInput {
    func playAudioByID(audioPacket: AudioPacket)
}

protocol AudioServiceOutput {}
