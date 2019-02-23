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
    private var currentAudioId = -1
    private var currentAudioPlayerData: AudioPlayerData?
    
    private var newsLoadQueue = OperationQueue()
    private var audioLoadQueue = OperationQueue()
    private var playingAudioQueue = DispatchQueue(label: "Interactor audio queue")
    
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
    
    func playAudio(audioPacket: AudioPacket) {
        playingAudioQueue.sync {
            if(currentAudioId == audioPacket.audioId) {
                guard let _ = self.currentAudioPlayerData else { return }
                self.audioPlayer.wakeUpPreviuosPlay()
            } else {
                let url = URL(string: "http://www.sa27086-29774.smrtp.ru/?owner_id=\(audioPacket.ownerId)&id=\(audioPacket.audioId)")
                internetService.loadData(fromURL: url, parseInto: AudioData.self, queue: audioLoadQueue, success: { (response: AudioData) in
                    guard let duration = response.response[0].duration else { return }
                    guard let songUrl = response.response[0].url else { return }
                    let audioPlayerData = AudioPlayerData(url: songUrl,
                                                          duration: duration,
                                                          title: audioPacket.title,
                                                          artist: audioPacket.artist)
                    self.currentAudioId = audioPacket.audioId
                    self.currentAudioPlayerData = audioPlayerData
                    self.audioPlayer.play(audioData: audioPlayerData,
                                          stop: audioPacket.stopClosure,
                                          setProgress: audioPacket.setProgressClosure,
                                          play: audioPacket.playClosure)
                }) { (code) in
                    print("Error")
                }
            }
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
