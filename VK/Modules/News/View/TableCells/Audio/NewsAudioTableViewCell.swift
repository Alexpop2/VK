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
    
    var viewModel: NewsAudioTableViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            songNameLabel.text = "\(viewModel.audioArtist) - \(viewModel.audioTitle)"
            progressView.progress = 0.0
            
            //print(Unmanaged.passUnretained(progressView).toOpaque())
        }
    }
    
    @IBAction func playClicked(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        delegate.audioPlayClicked(audioPacket: AudioPacket(ownerId: viewModel.audioOwnerId,
                                                           audioId: viewModel.audioId,
                                                           title: viewModel.audioTitle,
                                                           artist: viewModel.audioArtist,
                                                           stopClosure: { self.playButton.isSelected = false },
                                                           setProgressClosure: {progressValue,animated in
                                                            self.progressView.setProgress(progressValue, animated: animated)},
                                                           playClosure: { self.playButton.isSelected = true }))
    }
    
//    override func prepareForReuse() {
//        songNameLabel.text = nil
//        progressView.progress = 0.0
//        playButton.image(for: .normal)
//        super.prepareForReuse()
//    }
    
}
