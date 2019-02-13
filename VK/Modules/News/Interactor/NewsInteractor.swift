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
    
    var database: DatabaseServiceInput!
    var internetService: InternetServiceInput!
    
    var token: String = ""
}

extension NewsInteractor: NewsInteractorInput {
    
    func loadToken() {
        guard let token = database.loadToken() else {
            interactorOutput.authorizationRequired()
            return
        }
        self.token = token
    }
    
    func getNews() {
        let url = URL(string: "https://api.vk.com/method/newsfeed.get?access_token=\(token)&v=5.52")
        internetService.loadData(fromURL: url, parseInto: Newsfeed.self, success: { (response: Newsfeed) in
            
            guard let newsItems = response.response.items else {
                return
            }
            var parsedItems = [NewsItem]()
            
            for newsItem in newsItems {
                switch newsItem.type {
                case "post":
                    guard let text = newsItem.text else { continue }
                    parsedItems.append(NewsItem(id: newsItem.source_id, text: "ID \(newsItem.source_id) \(text)", newsType: newsItem.type))
                    guard let attachments = newsItem.attachments else { continue }
                    for attachment in attachments {
                        switch attachment.type {
                        case "photo":
                            parsedItems.append(NewsItem(id: newsItem.source_id,
                                                        text: "ID \(newsItem.source_id)",
                                                        newsType: "one_photo",
                                                        photo: attachment.photo))
                        default:
                            continue
                        }
                    }
                case "photo":
                    guard let photos = newsItem.photos else { continue }
                    guard let photosItems = photos.items else { continue }
                    parsedItems.append(NewsItem(id: newsItem.source_id,
                                                text: "ID \(newsItem.source_id)",
                                                newsType: newsItem.type,
                                                photos: photosItems))
                case "wall_photo":
                    guard let photos = newsItem.photos else { continue }
                    guard let photosItems = photos.items else { continue }
                    parsedItems.append(NewsItem(id: newsItem.source_id,
                                                text: "ID \(newsItem.source_id)",
                                                newsType: newsItem.type,
                                                photos: photosItems))
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
