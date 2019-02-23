//
//  NewsSectionBuilderProtocols.swift
//  VK
//
//  Created by Рабочий on 21/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol NewsSectionBuilder: class {
    func reset()
    func buildHeader(title: String)
    func buildPost(text: String)
    func buildVideo(item: Video)
    func buildAudio(item: Audio)
    func buildPhotos(items: [PhotoItem])
    func buildOnePhoto(item: PhotoItem)
    func buildFooter(likes: Int, reposts: Int)
    func getResult() -> NewsTableSection
}
