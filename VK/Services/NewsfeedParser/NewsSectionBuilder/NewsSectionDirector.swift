//
//  NewsSectionDirector.swift
//  VK
//
//  Created by Рабочий on 21/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

class NewsSectionDirector {
    
    // MARK: - private properties
    
    private var builder: NewsSectionBuilder
    private let profiles: [Profile]
    private let groups: [Group]
    
    // MARK: - Setting builder, VK profiles data, VK groups data
    
    init(builder: NewsSectionBuilder, profiles: [Profile], groups: [Group]) {
        self.builder = builder
        self.profiles = profiles
        self.groups = groups
    }
    
    // MARK: - Building section
    
    func makePost(newsItem: NewsItems) {
        builder.reset()
        
        // MARK: Building title
        
        if((newsItem.source_id ?? newsItem.owner_id ?? 0) < 0) {
            guard let group = groups.first(where: { $0.id == ((newsItem.source_id ?? newsItem.owner_id ?? 0) * -1) } ) else {
                return
            }
            builder.buildHeader(title: group.name)
        }
        if((newsItem.source_id ?? newsItem.owner_id ?? 0) > 0) {
            guard let profile = profiles.first(where: { $0.id == (newsItem.source_id ?? newsItem.owner_id ?? 0) } ) else {
                return
            }
            builder.buildHeader(title: "\(profile.first_name) \(profile.last_name)")
        }
        
        // MARK: Building text
        
        if(newsItem.text != nil && newsItem.text != "") {
            builder.buildPost(text: newsItem.text!)
        }
        
        // MARK: Building attachments
        
        if(newsItem.attachments != nil) {
            var firstPhoto = false
            var photoArray = [PhotoItem]()
            for attachment in newsItem.attachments! {
                switch attachment.type {
                case "photo":
                    guard let photo = attachment.photo else { continue }
                    if(!firstPhoto) {
                        firstPhoto = true
                        builder.buildOnePhoto(item: photo)
                    } else {
                        photoArray.append(photo)
                    }
                case "video":
                    guard let video = attachment.video else { continue }
                    builder.buildVideo(item: video)
                default:
                    continue
                }
            }
            if(photoArray.count > 0) {
                builder.buildPhotos(items: photoArray)
            }
        }
        
        // MARK: Building Extra types
        
        if(newsItem.extra_type != nil) {
            for type in newsItem.extra_type! {
                switch type {
                case "wall_photo":
                    guard let photos = newsItem.photos else { return }
                    guard let photoItems = photos.items else { return }
                    builder.buildPhotos(items: photoItems)
                default:
                    continue
                }
            }
        }
        
        // MARK: Building footer
        
        if(newsItem.likes != nil && newsItem.reposts != nil) {
            builder.buildFooter(likes: newsItem.likes!.count, reposts: newsItem.reposts!.count)
        }
    }

}
