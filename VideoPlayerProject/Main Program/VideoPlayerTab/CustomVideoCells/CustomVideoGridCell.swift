//
//  CustomVideoGridCell.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-09.
//

import Foundation
import UIKit
import AVKit
import SwiftUI

class CustomVideoGridCell: UICollectionViewCell {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "person.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        contentView.addSubview(imageView)
        self.imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        self.layer.cornerRadius = 5
        self.backgroundColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(image: UIImage) {
        self.imageView.image = image
    }
    
    func setVideo(video: Video) {
        setVideo(fileName: video.title, ofType: video.format)
    }
    
    func setVideo(fileName: String, ofType: String) {
        // Retrieveing video's path from bundle
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: ofType) else {
            print("Unable to find the image from bundle.")
            imageView.image = nil
            return
        }
        // Retrieving video asset from video
        let videoURL = URL(fileURLWithPath: filePath)
        let asset = AVAsset(url: videoURL)
        imageView.image = imageGeneratorFromVideo(asset: asset) // This function is written in extention to UICollectionViewCell
    }
}
