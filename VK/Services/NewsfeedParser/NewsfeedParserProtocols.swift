//
//  NewsfeedParserProtocols.swift
//  VK
//
//  Created by Рабочий on 21/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation

protocol NewsfeedParserInput: class {
    func parse(data: Newsfeed, completion: ([NewsTableSection]) -> Void)
}

protocol NewsfeedParserOutput: class {}
