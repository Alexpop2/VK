//
//  NewsfeedResponse.swift
//  VK
//
//  Created by Рабочий on 08/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

struct Newsfeed: Codable {
    var response: NewsResponse
}

struct NewsResponse: Codable {
    var items: [NewsItems]?
}

struct NewsItems: Codable {
    var text: String?
    var type: String
    var photos: Photos?
    var source_id: Int
    var attachments: [Attachments]?
}

struct Attachments: Codable {
    var type: String
    var photo: PhotoItem?
}

struct Photos: Codable {
    var items: [PhotoItem]?
}

struct PhotoItem: Codable {
    var text: String?
    var photo_75: String?
    var photo_1280: String?
    var photo_807: String?
    var width: Int?
    var height: Int?
}

extension PhotoItem: NewsPhotoCollectionViewCellViewModel {
    var photo: String {
        return photo_75!
    }
}

extension PhotoItem: NewsWallPhotoTableViewCellViewModel {
    var widthWallPhoto: Int {
        return width!
    }
    
    var heightWallPhoto: Int {
        return height!
    }
    
    var wallPhoto: String {
        return photo_807!
    }
    
    
}
