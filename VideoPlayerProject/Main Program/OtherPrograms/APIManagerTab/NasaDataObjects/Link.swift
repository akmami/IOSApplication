//
//  Link.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-18.
//

import Foundation
import RealmSwift

class Link: Object {
    private enum CodingKeys: String, CodingKey { case next = "next", prev = "prev", itself = "self"}
    @objc dynamic var next: String?
    @objc dynamic var prev: String?
    @objc dynamic var itself: String?
}

