//
//  ProfileInformationCollectionViewCell.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-22.
//

import UIKit

class ProfileInformationCollectionViewCell: UICollectionReusableView {
    
    var isCellExpandable: Bool? {
        didSet {
            if isCellExpandable! {
                expandCell()
            }
        }
    }
    var allHobbies: [String]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func expandCell() {
        
    }
}
