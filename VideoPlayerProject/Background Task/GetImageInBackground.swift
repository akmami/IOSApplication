//
//  GetImageInBackground.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-04.
//

import Foundation
import SwiftUI
import Photos
import CoreData

extension PHAsset {
    
    static func assetToUIImage(asset: PHAsset) -> UIImage {
        var resultImage = UIImage()
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .none
        
        manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { (image, _) in
            if let img = image {
                resultImage = img
            }
        }
        return resultImage
    }
}

class GetImageInBackground: UIView {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let viewFromXib = Bundle.main.loadNibNamed("GetImageInBackground", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.frame
        addSubview(viewFromXib)
        
        // Fetch the image
        PHPhotoLibrary.requestAuthorization { (status) in
            DispatchQueue.main.async {
                switch status {
                    case .authorized:
                        let asset = self.fetchFirstImageFromGallery()
                        self.image.image = self.assetToUIImage(asset)
//                        self.image.image = self.fetchFirstImagesFromCoreData()
                        self.label.text = "The first image from Gallery"
                    default:
                        print("Problem with autherization.")
                }
            }
        }
    }
    
    func fetchFirstImageFromGallery() -> PHAsset {
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        return assets.object(at: 0)
    }
    
    func fetchAllImagesFromGallery() -> [PHAsset] {
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        return assets.objects(at: IndexSet(arrayLiteral: 0,assets.count-1))
    }
    
    func fetchFirstImagesFromCoreData() -> UIImage {
        let request: NSFetchRequest<FetchedImage> = FetchedImage.fetchRequest()
        let data = (try? self.context.fetch(request)) ?? []
        if data.count == 0 {
            print("The CoreData is empty")
            return UIImage()
        }
        return UIImage(data: data[0].image!)!
    }
    
    func assetToUIImage(_ asset: PHAsset) -> UIImage {
        var resultImage = UIImage()
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .none
        manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { (image, _) in
            if let img = image {
                resultImage = img
            }
        }
        return resultImage
    }
}


