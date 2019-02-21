//
//  NewsVideoTableViewCell.swift
//  VK
//
//  Created by Рабочий on 16/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import UIKit
import Kingfisher

class NewsVideoTableViewCell: UITableViewCell {
    @IBOutlet weak var wallPhotoImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    
    var viewModel: NewsVideoTableViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            guard let photoUrl = URL(string: viewModel.videoFrame) else { return }
            wallPhotoImageView.kf.setImage(with: photoUrl)
            playButton.layer.borderWidth = 0
        }
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
    }
    
}
