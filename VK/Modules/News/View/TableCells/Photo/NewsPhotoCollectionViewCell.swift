//
//  NewsPhotoCollectionViewCell.swift
//  VK
//
//  Created by Рабочий on 16/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import UIKit
import Kingfisher

class NewsPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel: NewsPhotoCollectionViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            guard let photoUrl = URL(string: viewModel.photo) else { return }
            imageView.kf.setImage(with: photoUrl)
        }
    }
    
}
