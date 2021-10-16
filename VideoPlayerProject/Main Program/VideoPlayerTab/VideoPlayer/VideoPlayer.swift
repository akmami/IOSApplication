//
//  VideoPlayer.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-01.
//

import UIKit
import AVKit
import SwiftUI

class VideoPlayer: UIView {
    
    @IBOutlet weak var vwPlayer: UIView!    // Entire View
    @IBOutlet weak var forward: UIButton!
    @IBOutlet weak var rewind: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var progress: UISlider!
    @IBOutlet weak var currentDuration: UILabel!
    @IBOutlet weak var videoDuraction: UILabel!
    
    let forwardTime: Float64 = 5
    let rewindTime: Float64 = 5
    
    var player: AVPlayer?
    var isPause: Bool = true
    var fileName: String = ""
    var ofType: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit(_ fileName: String, ofType type: String) {
        let viewFromXib = Bundle.main.loadNibNamed("VideoPlayer", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.frame
        addSubview(viewFromXib)
        addPlayerToView(self.vwPlayer)
        playVideoWithFileName(fileName, ofType: type)
    }
    
    fileprivate func addPlayerToView(_ view: UIView) {
        // Add Player
        player = AVPlayer()
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspect // to fill screen
        view.layer.addSublayer(playerLayer) // make video layer visible(load video)
    }
    
    func playVideoWithFileName(_ fileName: String, ofType type: String) {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: type) else { return }
        let videoURL = URL(fileURLWithPath: filePath)
        let playerItem = AVPlayerItem(url: videoURL)
        player?.replaceCurrentItem(with: playerItem)
        player?.play()
        isPause = false
        
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        player?.addPeriodicTimeObserver(forInterval: CMTime(value:1, timescale: 1),
                                        queue: .main, using: { [weak self] (progressTime) in
                                            // modify time in label
                                            let seconds = CMTimeGetSeconds(progressTime)
                                            let secondsText = Int(seconds) % 60
                                            var minutesText = Int(seconds / 60)
                                            let hoursText = Int(minutesText / 60)
                                            if hoursText > 0 {
                                                minutesText = minutesText % 60
                                            }
                                            self!.currentDuration.text = String(format: "%02d:%02d:%02d", hoursText, minutesText, secondsText)
                                            // modify time in slider
                                            if let duration = self!.player?.currentItem?.duration {
                                                let videoLength = CMTimeGetSeconds(duration)
                                                self!.progress.value = Float(seconds / videoLength)
                                            }
                                        })
        // Set button
        pause.setImage(UIImage(systemName: "pause"), for: UIControl.State.normal)
        forward.setImage(UIImage(systemName: "goforward"), for: UIControl.State.normal)
        rewind.setImage(UIImage(systemName: "gobackward"), for: UIControl.State.normal)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let secondsText = Int(seconds) % 60
                var minutesText = Int(seconds / 60)
                let hoursText = Int(minutesText / 60)
                if hoursText > 0 {
                    minutesText = minutesText % 60
                }
                videoDuraction.text = String(format: "%02d:%02d:%02d", hoursText, minutesText, secondsText)
            }
        }
    }

    @IBAction func rewindVideo(_ sender: UIButton) {
        if let currentTime = player?.currentTime() {
            var newTime = CMTimeGetSeconds(currentTime) - rewindTime
            if newTime <= 0 {
                newTime = 0
            }
            player?.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
            print("Video is rewinded")
        }
    }
    
    @IBAction func forwardVideo(_ sender: UIButton) {
        if let currentTime = player?.currentTime(), let duration = player?.currentItem?.duration {
            var newTime = CMTimeGetSeconds(currentTime) + forwardTime
            if newTime >= CMTimeGetSeconds(duration) {
                newTime = CMTimeGetSeconds(duration)
            }
            player?.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
            print("Video is forwarded")
        }
    }
    
    @IBAction func pauseVideo(_ sender: UIButton) {
        if (!isPause) {
            player?.pause()
            pause.setImage(UIImage(systemName: "play"), for: .normal)
            print("Video is stopped.")
            isPause = !isPause
        } else {
            player?.play()
            self.pause.setImage(UIImage(systemName: "pause"), for: .normal)
            print("Video is continued.")
            isPause = !isPause
        }
    }
    
    @IBAction func sliderAttributes(_ sender: UISlider) {
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(progress.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { [weak self] (completedSeek) in
                self!.player?.play()
            })
        }
    }
}
