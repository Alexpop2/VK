//
//  NewsNewsInteractor.swift
//  VK
//
//  Created by Alexey Poponin on 07/02/2019.
//  Copyright © 2019 Aleksei Poponin. All rights reserved.
//

import Foundation

class NewsInteractor {
    private var interactorOutput: NewsInteractorOutput!
    
    var keyValueStorage: KeyValueStorageInput!
    var internetService: InternetServiceInput!
    
    var token: String = ""
}

extension NewsInteractor: NewsInteractorInput {
    
    func loadToken() {
        keyValueStorage.loadValue(byKey: "vk-token") { (data) in
            guard let token = data else {
                interactorOutput.authorizationRequired()
                return
            }
            self.token = token
        }
    }
    
    func getNews() {
        print(token)
        let url = URL(string: "https://api.vk.com/method/newsfeed.get?access_token=\(token)&v=5.52")
        internetService.loadData(fromURL: url, parseInto: Newsfeed.self, success: { (response: Newsfeed) in
            
            guard let newsItems = response.response.items else {
                return
            }
            guard let groups = response.response.groups else {
                return
            }
            guard let profiles = response.response.profiles else {
                return
            }
            var parsedItems = [NewsItem]()
            var usedPhotos = [Int]()
            var usedPosts = [Int]()
            
            for newsItem in newsItems {
                switch newsItem.type {
                case "post":
                    guard let post_id = newsItem.post_id else { continue }
                    if(usedPosts.contains(post_id)) {
                        continue
                    }
                    usedPosts.append(post_id)
                    if(newsItem.source_id < 0) {
                        guard let group = groups.first(where: { $0.id == (newsItem.source_id * -1) } ) else {
                            return
                        }
                        parsedItems.append(NewsItem(id: newsItem.source_id, text: group.name, newsType: "title"))
                    }
                    if(newsItem.source_id > 0) {
                        guard let profile = profiles.first(where: { $0.id == newsItem.source_id } ) else {
                            return
                        }
                        parsedItems.append(NewsItem(id: newsItem.source_id,
                                                    text: "\(profile.first_name) \(profile.last_name)",
                                                    newsType: "title"))
                    }
                    
                    guard let text = newsItem.text else { continue }

                    parsedItems.append(NewsItem(id: newsItem.source_id, text: "\(text)", newsType: newsItem.type))
                    guard let attachments = newsItem.attachments else { continue }
                    var firstPhoto = false
                    var photoArray = [PhotoItem]()
                    for attachment in attachments {
                        switch attachment.type {
                        case "photo":
                            guard let photo = attachment.photo else { continue }
                            usedPhotos.append(photo.id)
                            if(!firstPhoto) {
                                firstPhoto = true
                                parsedItems.append(NewsItem(id: newsItem.source_id,
                                                            text: "",
                                                            newsType: "one_photo",
                                                            photo: photo))
                            } else {
                                photoArray.append(photo)
                            }

                        default:
                            continue
                        }
                    }
                    if(photoArray.count > 0) {
                        parsedItems.append(NewsItem(id: newsItem.source_id,
                                                    text: "",
                                                    newsType: "photo",
                                                    photos: photoArray))
                    }
                case "photo":
                    guard let photos = newsItem.photos else { continue }
                    guard let photosItems = photos.items else { continue }
                    parsedItems.append(NewsItem(id: newsItem.source_id,
                                                text: "",
                                                newsType: newsItem.type,
                                                photos: photosItems))
                case "wall_photo":
                    guard let photos = newsItem.photos else { continue }
                    guard let photosItems = photos.items else { continue }
                    let showPhotoItems = photosItems.filter({
                        return !usedPhotos.contains($0.id)
                    })
                    if(showPhotoItems.count > 0) {
                        parsedItems.append(NewsItem(id: newsItem.source_id,
                                                    text: "",
                                                    newsType: newsItem.type,
                                                    photos: showPhotoItems))
                    }
                    usedPhotos.removeAll()
                default:
                    continue
                }
            }
            self.interactorOutput.setDataSource(parsedInput: parsedItems)
        }) { (code) in
            print("Error")
        }
    }
    
    var output: NewsInteractorOutput {
        get {
            return interactorOutput
        }
        set {
            interactorOutput = newValue
        }
    }
}
