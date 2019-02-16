//
//  NewsItem.swift
//  VK
//
//  Created by Рабочий on 08/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

class NewsItem {
    var text: String
    var newsType: String
    var photos: [PhotoItem]
    var photo: PhotoItem?
    var id: Int
    
    init(id: Int, text: String, newsType: String) {
        self.text = text
        self.newsType = newsType
        self.photos = []
        self.id = id
    }
    
    init(id: Int, text: String, newsType: String, photos: [PhotoItem]) {
        self.text = text
        self.newsType = newsType
        self.photos = photos
        self.id = id
    }
    
    init(id: Int, text: String, newsType: String, photo: PhotoItem?) {
        self.text = text
        self.newsType = newsType
        self.photo = photo
        self.photos = []
        self.id = id
    }
}

extension NewsItem: NewsTitleTableViewCellViewModel {
    var title: String {
        return text
    }
    
}

extension NewsItem: NewsTextTableViewCellViewModel {
    
}

extension NewsItem: NewsPhotoTableViewCellViewModel {
    var photosItems: [PhotoItem] {
        return photos
    }
}

extension NewsItem: NewsWallPhotoTableViewCellViewModel {
    var widthWallPhoto: Int {
        return photo?.width ?? 0
    }
    
    var heightWallPhoto: Int {
        return photo?.height ?? 0
    }
    
    var wallPhoto: String {
        return photo?.photo_807 ?? photo?.photo_604 ?? ""
    }
    
    
}
