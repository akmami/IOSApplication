//
//  VideoPlayerViewController.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-07.
//

import UIKit

class VideoPlayerViewController: UIViewController, VideoDelegateProtocol {
    
    @IBOutlet weak var player: VideoPlayer!
    var video: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player?.commonInit(video!.title, ofType: video!.format)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.main.async {
            self.player?.player?.pause()
            self.player?.player?.replaceCurrentItem(with: nil)
            NotificationCenter.default.removeObserver(self)
            print("leaving from VideoPlayerViewController")
        }
    }
    
    func setVideo(_ video: Video) {
        self.video = video
    }
}
