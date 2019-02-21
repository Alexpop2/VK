//
//  BaseNewsItemBuilder.swift
//  VK
//
//  Created by Рабочий on 21/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

class BaseNewsItemBuilder {
    private var newsItem: NewsItem!
}

extension BaseNewsItemBuilder: NewsItemBuilder {
    
    func getResult() -> NewsItem {
        return newsItem
    }
    
    func reset() {
        newsItem = NewsItem()
    }
    
    func buildText(data: String) {
        newsItem.text = data
    }
    
    func buildType(data: NewsItemsType) {
        newsItem.newsType = data
    }
    
    func buildPhotos(data: [PhotoItem]) {
        newsItem.photos = data
    }
    
    func buildPhoto(data: PhotoItem) {
        newsItem.photo = data
    }
    
    func buildVideo(data: Video) {
        newsItem.video = data
    }
    
    func buildLikes(data: Int) {
        newsItem.likes = data
    }
    
    func buildReposts(data: Int) {
        newsItem.reposts = data
    }
    
}
