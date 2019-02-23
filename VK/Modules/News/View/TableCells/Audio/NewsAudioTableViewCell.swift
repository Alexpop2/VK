//
//  NewsAudioTableViewCell.swift
//  VK
//
//  Created by Рабочий on 23/02/2019.
//  Copyright © 2019 Рабочий. All rights reserved.
//

import Foundation
import AVFoundation
import MediaPlayer
import UIKit

class NewsAudioTableViewCell: UITableViewCell {

    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    weak var delegate: NewsAudioTableViewCellDelegate!
    
    private var songUrl = ""
    private var songDuration = 1
    private var updater : CADisplayLink! = nil
    private var player : AVPlayer! = nil
    
    var viewModel: NewsAudioTableViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            songNameLabel.text = "\(viewModel.audioArtist) - \(viewModel.audioTitle)"
            progressView.progress = 0.0
        }
    }
    
    @IBAction func playClicked(_ sender: UIButton) {
        if(songUrl == "") {
            guard let audioViewModel = viewModel else { return }
            let audioPacket = AudioPacket(ownerId: audioViewModel.audioOwnerId,
                                          audioId: audioViewModel.audioId,
                                          callBack: {(url, duration) in
                self.songUrl = url
                self.songDuration = duration
                //self.songUrl = "https://www.myinstants.com/media/sounds/cade-o-respeito.mp3"
                //self.songDuration = 5
                self.playClicked(sender)
            })
            delegate.audioPlayClicked(audioPacket: audioPacket)
        } else {
            playButton.isSelected = !(playButton.isSelected)
            if playButton.isSelected {
                setupLockScreen()
                if(updater == nil) {
                    updater = CADisplayLink(target: self, selector: #selector(NewsAudioTableViewCell.trackAudio))
                    updater.preferredFramesPerSecond = 1
                    updater.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
                    
                    guard let fileURL = URL(string: songUrl) else { return }
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
        if(playButton.isSelected) {
            guard let audioPlayer = player else { return }
            let normalizedTime = Float((Float(audioPlayer.currentTime().seconds)) / Float(songDuration))
            progressView.setProgress(normalizedTime, animated: true)
        }
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        updater.remove(from: RunLoop.current, forMode: RunLoop.Mode.common)
        updater.invalidate()
        updater = nil
        playButton.isSelected = false
        progressView.setProgress(0.0, animated: false)
    }
    
    func setupLockScreen(){
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.togglePlayPauseCommand.addTarget(self, action: #selector(controlPause))
        MPNowPlayingInfoCenter.default().nowPlayingInfo =
            [MPMediaItemPropertyTitle: "\(viewModel?.audioArtist ?? "") - \(viewModel?.audioTitle ?? "")"]
    }
    
    @objc func controlPause() {
        if playButton.isSelected == true {
            player?.pause()
            playButton.isSelected = false
        } else {
            player?.play()
            playButton.isSelected = true
        }
    }
    
}
