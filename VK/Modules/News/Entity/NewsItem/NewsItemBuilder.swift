//
//  NewsItemBuilder.swift
//  VK
//
//  Created by Рабочий on 21/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol NewsItemBuilder {
    func reset()
    func buildText(data: String)
    func buildType(data: NewsItemsType)
    func buildPhotos(data: [PhotoItem])
    func buildPhoto(data: PhotoItem)
    func buildVideo(data: Video)
    func buildAudio(data: Audio)
    func buildLikes(data: Int)
    func buildReposts(data: Int)
    func getResult() -> NewsItem
}
