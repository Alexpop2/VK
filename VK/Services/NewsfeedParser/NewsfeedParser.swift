//
//  NewsfeedParser.swift
//  VK
//
//  Created by Рабочий on 21/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

class NewsfeedParser {}

extension NewsfeedParser: NewsfeedParserInput {
    
    // MARK: - Parsing response from vk into table sections
    
    func parse(data: Newsfeed, completion: ([NewsTableSection]) -> Void) {
        guard let newsItems = data.response.items else {
            return
        }
        guard let groups = data.response.groups else {
            return
        }
        guard let profiles = data.response.profiles else {
            return
        }
        var sections = [NewsTableSection]()
        let postParser = PostParser()
        let parsedNewItems = postParser.normalizeResponse(items: newsItems)
        let newsSectionBuilder = BaseNewsSectionBuilder(newsItemBuilder: BaseNewsItemBuilder())
        let newsSectionDirector = NewsSectionDirector(builder: newsSectionBuilder, profiles: profiles, groups: groups)
        
        for newsItem in parsedNewItems {
            switch (newsItem.type ?? newsItem.post_type) {
            case "post":
                newsSectionDirector.makePost(newsItem: newsItem)
            default:
                continue
            }
            sections.append(newsSectionBuilder.getResult())
        }
        completion(sections)
    }
}
