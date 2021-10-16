//
//  ProgramCollectionViewCell.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-02.
//

import UIKit
import SwiftUI

class ProgramCollectionViewCell: UICollectionViewCell {
    
    var programTitleTextField: UILabel = {
        let textFiled = UILabel()
        textFiled.translatesAutoresizingMaskIntoConstraints = false
        textFiled.textColor = .black
        return textFiled
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(programTitleTextField)
        self.programTitleTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.programTitleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        self.programTitleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
        self.programTitleTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.programTitleTextField.widthAnchor.constraint(equalToConstant: self.frame.width - 10).isActive = true
        self.programTitleTextField.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ title: String) {
        programTitleTextField.text = title
    }
}
