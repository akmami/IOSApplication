//
//  CustomVideoListCell.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-07.
//
import UIKit
import SwiftUI
import Foundation
import AVKit

class CustomVideoListCell: UICollectionViewCell {

    var videoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "photo")
        return imageView
    }()
    
    var videoTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var videoDuration: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        self.clipsToBounds = true
        
        self.addSubview(videoImage)
        self.addSubview(videoTitle)
        self.addSubview(videoDuration)
        
        videoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        videoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        videoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        videoImage.widthAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        videoImage.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true

        videoTitle.leadingAnchor.constraint(equalTo: videoImage.trailingAnchor, constant: 8).isActive = true
        videoTitle.topAnchor.constraint(equalTo: videoImage.topAnchor, constant: 25).isActive = true
        videoTitle.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        videoDuration.topAnchor.constraint(equalTo: videoTitle.bottomAnchor, constant: 4).isActive = true
        videoDuration.leadingAnchor.constraint(equalTo: videoImage.trailingAnchor, constant: 8).isActive = true
        videoDuration.bottomAnchor.constraint(equalTo: videoImage.bottomAnchor, constant: -4).isActive = true
        videoDuration.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        videoDuration.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        self.backgroundColor = .gray
        self.layer.cornerRadius = 5
    }
    
    func setVideo(video: Video) {   // implementation of protocol
        setVideoInformations(fileName: video.title, ofType: video.format)
        videoTitle.text = video.title
    }
    
    // Here is a bug on assigning Image to videoImage.
    // If assignment would happend directly, the cell of the UItable will have large height,
    // resulting from the height of the image
    func setVideoInformations(fileName: String, ofType: String) {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: ofType) else {
            print("Unable to find the image from bundle.")
            videoImage.image = nil
            return
        }
        let videoURL = URL(fileURLWithPath: filePath)
        let asset = AVAsset(url: videoURL)
        
        // Set video's image
        self.videoImage.translatesAutoresizingMaskIntoConstraints = false
        self.videoImage.contentMode = .scaleAspectFit
        self.videoImage.clipsToBounds = true
        videoImage.image = imageGeneratorFromVideo(asset: asset)  // This function is written in extention to UICollectionViewCell
        
        // Set video's duration
        let seconds = Int(asset.duration.seconds)
        let duration = String(format: "%02d:%02d:%02d", Int(seconds/(3600)), Int((seconds/60)%60), seconds%60)
        videoDuration.text = duration
    }
}
