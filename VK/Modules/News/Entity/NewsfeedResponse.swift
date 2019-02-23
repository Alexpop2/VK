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
    var profiles: [Profile]?
    var groups: [Group]?
}

struct Profile: Codable {
    var id: Int
    var first_name: String
    var last_name: String
    var online: Int
}

struct Group: Codable {
    var id: Int
    var name: String
}

struct NewsItems: Codable {
    var text: String?
    var type: String?
    var post_type: String?
    var photos: Photos?
    var source_id: Int?
    var owner_id: Int?
    var attachments: [Attachments]?
    var post_id: Int?
    var date: Int
    var likes: Likes?
    var reposts: Reposts?
    var id: Int?
    
    var extra_type: [String]?
}

struct Likes: Codable {
    var count: Int
}

struct Reposts: Codable {
    var count: Int
}

struct Attachments: Codable {
    var type: String
    var photo: PhotoItem?
    var video: Video?
    var audio: Audio?
}

struct Audio: Codable {
    var id: Int
    var owner_id: Int
    var artist: String
    var title: String
}

struct Video: Codable {
    var id: Int
    var owner_id: Int
    var first_frame_320: String?
    var width: Int?
    var height: Int?
    var photo_320: String?
}

struct Photos: Codable {
    var items: [PhotoItem]?
}

struct PhotoItem: Codable {
    var text: String?
    var photo_75: String?
    var photo_1280: String?
    var photo_807: String?
    var photo_604: String?
    var width: Int?
    var height: Int?
    var id: Int
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
