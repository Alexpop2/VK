//
//  NewsAudioTableViewCellDelegate.swift
//  VK
//
//  Created by Рабочий on 23/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol NewsAudioTableViewCellDelegate: class {
    func audioPlayClicked(audioPacket: AudioPacket)
}
