//
//  NewsWallPhotoTableViewCell.swift
//  VK
//
//  Created by Рабочий on 09/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import UIKit
import Kingfisher

class NewsWallPhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var wallPhotoImageView: UIImageView!
    
    var viewModel: NewsWallPhotoTableViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            guard let photoUrl = URL(string: viewModel.wallPhoto) else { return }
            wallPhotoImageView.kf.setImage(with: photoUrl)
        }
    }
    
}
