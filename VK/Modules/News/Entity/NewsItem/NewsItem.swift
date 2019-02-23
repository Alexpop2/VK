//
//  NewsItem.swift
//  VK
//
//  Created by Рабочий on 08/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

enum NewsItemsType: String {
    case post = "post"
    case title = "title"
    case photo = "photo"
    case one_photo = "one_photo"
    case video = "video"
    case audio = "audio"
    case wall_photo = "wall_photo"
    case like_repost = "like_repost"
    case empty = ""
}

class NewsItem {
    var text: String = ""
    var newsType: NewsItemsType = .empty
    var photos: [PhotoItem] = []
    var photo: PhotoItem?
    var video: Video?
    var audio: Audio?
    var likes: Int = 0
    var reposts: Int = 0
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

extension NewsItem: NewsVideoTableViewCellViewModel {
    var widthVideoFrame: Int {
        return video?.width ?? 1280
    }
    
    var heightVideoFrame: Int {
        return video?.height ?? 800
    }
    
    var videoFrame: String {
        return video?.first_frame_320 ?? video?.photo_320 ?? ""
    }
}

extension NewsItem: NewsFooterTableViewCellViewModel {
    var likesValue: Int {
        return likes
    }
    
    var repostsValue: Int {
        return reposts
    }
    
}

extension NewsItem: NewsAudioTableViewCellViewModel {
    var audioId: Int {
        return audio?.id ?? -1
    }
    
    var audioOwnerId: Int {
        return audio?.owner_id ?? 0
    }
    
    var audioTitle: String {
        return audio?.title ?? ""
    }
    
    var audioArtist: String {
        return audio?.artist ?? ""
    }
}
