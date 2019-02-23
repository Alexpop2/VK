//
//  NewsAudioTableViewCellViewModel.swift
//  VK
//
//  Created by Рабочий on 23/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol NewsAudioTableViewCellViewModel {
    var audioId: Int { get }
    var audioOwnerId: Int { get }
    var audioTitle: String { get }
    var audioArtist: String { get }
}
