//
//  PostParser.swift
//  VK
//
//  Created by Рабочий on 21/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

// MARK: - Transform response in normal view

class PostParser {
    func normalizeResponse(items: [NewsItems]) -> [NewsItems] {
        var usedPhotos = [Int]()
        var usedVideos = [Int]()
        var usedAudios = [Int]()
        var usedPosts = [Int]()
        var previousPostSourceID = 0
        var previousPostDate = 0
        var previousPostID = 0
        var parsedNewItems = [NewsItems]()
        
        for newsItem in items {
            switch (newsItem.type ?? newsItem.post_type) {
            case "post":
                guard let post_id = (newsItem.post_id ?? newsItem.id) else { continue }
                if(usedPosts.contains(post_id)) {
                    continue
                }
                usedPosts.append(post_id)
                previousPostSourceID = newsItem.source_id ?? newsItem.owner_id ?? 0
                previousPostDate = newsItem.date
                previousPostID = post_id
                
                guard let attachments = newsItem.attachments else { continue }
                for attachment in attachments {
                    switch attachment.type {
                    case "photo":
                        guard let photo = attachment.photo else { continue }
                        usedPhotos.append(photo.id)
                    case "video":
                        guard let video = attachment.video else { continue }
                        usedVideos.append(video.id)
                    case "audio":
                        guard let audio = attachment.audio else { continue }
                        usedAudios.append(audio.id)
                    default:
                        continue
                    }
                }
                
                parsedNewItems.append(newsItem)
                
            case "wall_photo":
                guard let photos = newsItem.photos else { continue }
                guard let photosItems = photos.items else { continue }
                let showPhotoItems = photosItems.filter({
                    return !usedPhotos.contains($0.id)
                })
                if(showPhotoItems.count > 0) {
                    if(previousPostSourceID == newsItem.source_id && (previousPostDate >= newsItem.date-2
                        && previousPostDate <= newsItem.date+2)) {
                        guard var previousPost = parsedNewItems.first(where: {$0.post_id == previousPostID}) else { continue }
                        if(previousPost.extra_type == nil) {
                            previousPost.extra_type = [newsItem.type ?? newsItem.post_type ?? ""]
                        } else {
                            if(previousPost.extra_type!.contains(newsItem.type ?? newsItem.post_type ?? "")) {
                                previousPost.photos?.items?.append(contentsOf: showPhotoItems)
                                continue
                            }
                            previousPost.extra_type?.append(newsItem.type ?? newsItem.post_type ?? "")
                        }
                        previousPost.photos = Photos()
                        previousPost.photos?.items = showPhotoItems
                    } else {
                        continue
                    }
                }
            default:
                continue
            }
        }
        
        return parsedNewItems
        
    }
}
