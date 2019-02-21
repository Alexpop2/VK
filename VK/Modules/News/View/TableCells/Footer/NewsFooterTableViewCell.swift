//
//  NewsFooterTableViewCell.swift
//  VK
//
//  Created by Рабочий on 21/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import UIKit

class NewsFooterTableViewCell: UITableViewCell {
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var LikesImageView: UIImageView!
    
    @IBOutlet weak var repostsLabel: UILabel!
    @IBOutlet weak var repostsImageView: UIImageView!
    var viewModel: NewsFooterTableViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            likesLabel.text = "\(viewModel.likesValue)"
            repostsLabel.text = "\(viewModel.repostsValue)"
            
        }
    }
    
}
