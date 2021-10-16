//
//  PopUpCustomCollectionViewCell.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-05.
//

import UIKit

class PopUpCustomCollectionViewCell: UICollectionViewCell {
    
    var textField1: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .black
        return textLabel
    }()
    var textField2: UILabel = {
        let textLabel  = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .black
        return textLabel
    }()

    var index = -1
    
    var items: [SelectionInPopUP]? {
        didSet {
            addSubview(self.textField1)
            self.textField1.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.textField1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
            self.textField1.widthAnchor.constraint(equalToConstant: self.frame.width - 10).isActive = true
            self.textField1.heightAnchor.constraint(equalToConstant: 30).isActive = true
            self.textField1.text = items![0].rawValue
            
            if self.items?.count == 2 {
                addSubview(self.textField2)
                self.textField2.topAnchor.constraint(equalTo: self.textField1.bottomAnchor).isActive = true
                self.textField2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
                self.textField2.widthAnchor.constraint(equalToConstant: self.frame.width - 10).isActive = true
                self.textField2.heightAnchor.constraint(equalToConstant: 30).isActive = true
                self.textField2.text = items![1].rawValue
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItems(items: [SelectionInPopUP], indexPath: Int) {
        index = indexPath
        self.items = items
    }
}
