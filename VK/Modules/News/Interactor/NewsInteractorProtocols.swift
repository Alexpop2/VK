//
//  NewsNewsInteractorProtocols.swift
//  VK
//
//  Created by Alexey Poponin on 07/02/2019.
//  Copyright © 2019 Aleksei Poponin. All rights reserved.
//

import Foundation

protocol NewsInteractorInput: class, AutoMockable {
    var output: NewsInteractorOutput { get set }
    
    func loadToken()
    func getNews()
    func searchNews(byText: String)
}

protocol NewsInteractorOutput: class, AutoMockable {
    func authorizationRequired()
    
    func setDataSource(parsedInput: [NewsTableSection]) 
}
