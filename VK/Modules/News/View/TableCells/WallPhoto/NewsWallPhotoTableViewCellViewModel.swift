//
//  NewsWallPhotoTableViewCellViewModel.swift
//  VK
//
//  Created by Рабочий on 09/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import UIKit

protocol NewsWallPhotoTableViewCellViewModel {
    var wallPhoto: String { get }
    var widthWallPhoto: Int { get }
    var heightWallPhoto: Int { get }
}
