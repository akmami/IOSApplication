//
//  UICollectionViewCell.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-08.
//

import AVKit

extension UICollectionViewCell {
    
    func imageGeneratorFromVideo(asset avAsset: AVAsset) -> UIImage? {
        let imageGenerator = AVAssetImageGenerator(asset: avAsset)
        imageGenerator.appliesPreferredTrackTransform = true
        var time = avAsset.duration
        time.value = min(time.value, 2)
        do {
            let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            let image = UIImage(cgImage: imageRef)
            return image
        } catch {
            print("Load image failed.")
            return nil
        }
    }
}
