//
//  NewsSectionBuilder.swift
//  VK
//
//  Created by Рабочий on 21/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

// MARK: - Section builder & Director for NewsItemBuilder

class BaseNewsSectionBuilder {
    private var section: NewsTableSection!
    private var newsItemBuilder: NewsItemBuilder
    
    init(newsItemBuilder: NewsItemBuilder) {
        self.newsItemBuilder = newsItemBuilder
    }
}

// MARK: - Build NewsItem step by step

extension BaseNewsSectionBuilder: NewsSectionBuilder {
    func buildHeader(title: String) {
        newsItemBuilder.reset()
        newsItemBuilder.buildText(data: title)
        newsItemBuilder.buildType(data: .title)
        section.newsItems.append(newsItemBuilder.getResult())
    }
    
    func buildPost(text: String) {
        newsItemBuilder.reset()
        newsItemBuilder.buildText(data: text)
        newsItemBuilder.buildType(data: .post)
        section.newsItems.append(newsItemBuilder.getResult())
    }
    
    func buildVideo(item: Video) {
        newsItemBuilder.reset()
        newsItemBuilder.buildVideo(data: item)
        newsItemBuilder.buildType(data: .video)
        section.newsItems.append(newsItemBuilder.getResult())
    }
    
    func buildAudio(item: Audio) {
        newsItemBuilder.reset()
        newsItemBuilder.buildAudio(data: item)
        newsItemBuilder.buildType(data: .audio)
        section.newsItems.append(newsItemBuilder.getResult())
    }
    
    func buildPhotos(items: [PhotoItem]) {
        newsItemBuilder.reset()
        newsItemBuilder.buildPhotos(data: items)
        newsItemBuilder.buildType(data: .photo)
        section.newsItems.append(newsItemBuilder.getResult())
    }
    
    func buildOnePhoto(item: PhotoItem) {
        newsItemBuilder.reset()
        newsItemBuilder.buildPhoto(data: item)
        newsItemBuilder.buildType(data: .one_photo)
        section.newsItems.append(newsItemBuilder.getResult())
    }
    
    func buildFooter(likes: Int, reposts: Int) {
        newsItemBuilder.reset()
        newsItemBuilder.buildLikes(data: likes)
        newsItemBuilder.buildReposts(data: reposts)
        newsItemBuilder.buildType(data: .like_repost)
        section.newsItems.append(newsItemBuilder.getResult())
    }
    
    func getResult() -> NewsTableSection {
        return section
    }
    
    func reset() {
        section = NewsTableSection(newsItems: [NewsItem]())
    }
    
}
