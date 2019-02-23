//
//  AudioPlayer.swift
//  VK
//
//  Created by Рабочий on 23/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer

class AudioPlayer {
    private var updater : CADisplayLink! = nil
    private var player : AVPlayer! = nil
    private var playing = false
    
    private var audioData: AudioPlayerData!
    private var stopClosure: (() -> Void)!
    private var setProgressClosure: ((Float,Bool) -> Void)!
    private var playClosure: (() -> Void)!
    
    private var playQueue = DispatchQueue(label: "audio play queue")
    
    func play(audioData: AudioPlayerData,
              stop: @escaping () -> Void,
              setProgress: @escaping (Float,Bool) -> Void,
              play: @escaping () -> Void) {
        playQueue.sync {
            playerDidFinishPlaying(note: NSNotification())
            stopClosure = stop
            setProgressClosure = setProgress
            playClosure = play
            self.audioData = audioData
            
            playing = !playing
            if playing {
                setupLockScreen()
                if(updater == nil) {
                    updater = CADisplayLink(target: self, selector: #selector(AudioPlayer.trackAudio))
                    updater.preferredFramesPerSecond = 1
                    updater.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
                    
                    guard let fileURL = URL(string: audioData.url) else { return }
                    let playerItem = AVPlayerItem(url: fileURL)
                    
                    
                    player = AVPlayer(playerItem: playerItem)
                    
                    NotificationCenter.default.addObserver(self,
                                                           selector: #selector(playerDidFinishPlaying),
                                                           name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                           object: playerItem)
                }
                
                player.play()
                //startTime.text = "\(player.currentTime)"
            } else {
                if(player != nil) {
                    player.pause()
                }
            }
        }
    }
    
    @objc func trackAudio() {
        if(playing) {
            guard let audioPlayer = player else { return }
            let normalizedTime = Float((Float(audioPlayer.currentTime().seconds)) / Float(audioData.duration))
            setProgressClosure(normalizedTime,true)
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        updater.remove(from: RunLoop.current, forMode: RunLoop.Mode.common)
        updater.invalidate()
        updater = nil
        setProgressClosure(0.0,false)
        stopClosure()
    }
    
    func setupLockScreen(){
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.togglePlayPauseCommand.addTarget(self, action: #selector(controlPause))
        MPNowPlayingInfoCenter.default().nowPlayingInfo =
            [MPMediaItemPropertyTitle: "\(audioData.artist) - \(audioData.title)"]
    }
    
    @objc func controlPause() {
        if playing == true {
            player?.pause()
            stopClosure()
            playing = false
        } else {
            player?.play()
            playClosure()
            playing = true
        }
    }
}
