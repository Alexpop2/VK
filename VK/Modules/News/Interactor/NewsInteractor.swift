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
    
    var token: String = ""
    
    private var audioPlayer = AudioPlayer()
    
    private var newsLoadQueue = OperationQueue()
    private var audioLoadQueue = OperationQueue()
    
    init() {
        newsLoadQueue.maxConcurrentOperationCount = 1
        audioLoadQueue = OperationQueue()
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
    
    func getAudioData(audioPacket: AudioPacket) {
        let url = URL(string: "http://www.sa27086-29774.smrtp.ru/?owner_id=\(audioPacket.ownerId)&id=\(audioPacket.audioId)")
        internetService.loadData(fromURL: url, parseInto: AudioData.self, queue: audioLoadQueue, success: { (response: AudioData) in
            guard let duration = response.response[0].duration else { return }
            guard let songUrl = response.response[0].url else { return }
            audioPacket.callBack(songUrl,duration)
        }) { (code) in
            print("Error")
        }
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
