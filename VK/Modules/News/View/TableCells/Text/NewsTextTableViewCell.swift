//
//  NewsTextTableViewCell.swift
//  VK
//
//  Created by Рабочий on 09/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import UIKit

class NewsTextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var viewModel: NewsTextTableViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
        }
    }
    
}
