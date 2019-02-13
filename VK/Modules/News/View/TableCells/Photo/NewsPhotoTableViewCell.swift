//
//  NewsPhotoTableViewCell.swift
//  VK
//
//  Created by Рабочий on 09/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import UIKit

class NewsPhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var dataSource = [PhotoItem]()
    
    private let newsPhotoCollectionReusableCellIdentifier = "NewsPhotoCollectionCellReusableIdentifier"
    
    var viewModel: NewsPhotoTableViewCellViewModel? {
        didSet {
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            guard let viewModel = viewModel else { return }
            
            dataSource = viewModel.photosItems
            collectionView.reloadData()
        }
    }
    
}

extension NewsPhotoTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newsPhotoCollectionReusableCellIdentifier, for: indexPath) as! NewsPhotoCollectionViewCell
        cell.viewModel = dataSource[indexPath.row]
        return cell
    }
    
    
}

extension NewsPhotoTableViewCell: UICollectionViewDelegate {
    
}
