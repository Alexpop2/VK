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
    var newsfeedParser: NewsfeedParserInput!
    var audioSerice: AudioServiceInput!
    
    var token: String = ""
    
    private var newsLoadQueue = OperationQueue()
    
    init() {
        newsLoadQueue.maxConcurrentOperationCount = 1
    }
}

extension NewsInteractor: NewsInteractorInput {
    func searchNews(byText: String) {
        let url = URL(string: "https://api.vk.com/method/newsfeed.search?access_token=\(token)&v=5.52&extended=1&q=\(byText.encodeUrl)")
        internetService.loadData(fromURL: url, parseInto: Newsfeed.self, queue: newsLoadQueue, success: { (response: Newsfeed) in
            self.newsfeedParser.parse(data: response, completion: { (sections) in
                self.interactorOutput.setDataSource(parsedInput: sections)
            })
        }) { (code) in
            print("Error")
        }
    }
    
    func playAudio(audioPacket: AudioPacket) {
        audioSerice.playAudioByID(audioPacket: audioPacket)
    }
    
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
        //print(token)
        let url = URL(string: "https://api.vk.com/method/newsfeed.get?access_token=\(token)&v=5.52")
        internetService.loadData(fromURL: url, parseInto: Newsfeed.self, queue: newsLoadQueue, success: { (response: Newsfeed) in
            self.newsfeedParser.parse(data: response, completion: { (sections) in
                self.interactorOutput.setDataSource(parsedInput: sections)
            })
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
