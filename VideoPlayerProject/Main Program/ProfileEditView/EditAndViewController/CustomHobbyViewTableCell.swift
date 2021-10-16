//
//  CustomHobbyViewTableCell.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-28.
//

import UIKit

// MARK: - This class is created but never used in tableview. Intead, talbes standart cell is used, hence, there is no delete option.
class CustomHobbyViewTableCell: UITableViewCell {

    @objc var didDelete: () -> ()  = {}

    let hobbyTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()

    let deleteButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("-", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return btn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(getter: didDelete), for: .touchUpInside)
        //Set constraints as per your requirements
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
