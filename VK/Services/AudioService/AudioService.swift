//
//  BaseAudioService.swift
//  VK
//
//  Created by Рабочий on 23/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import AVFoundation

class AudioService {
    var internetService: InternetServiceInput!
    
    private var audioPlayer = AudioPlayer()
    private var currentAudioId = -1
    private var currentAudioPlayerData: AudioPlayerData?
    
    private var audioLoadQueue = OperationQueue()
    private var playingAudioQueue = DispatchQueue(label: "Audio service queue")
    
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, policy: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
        }
        audioLoadQueue.maxConcurrentOperationCount = 1
    }
}

extension AudioService: AudioServiceInput {
    func playAudioByID(audioPacket: AudioPacket) {
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
}
