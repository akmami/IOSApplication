//
//  CelestialBodies.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-18.
//

import Foundation
import RealmSwift

class CelestialBodies: Object {
    private enum CodingKeys: String, CodingKey { case date1 = "2015-09-08"}
    @objc dynamic var date1: Asteroid?
}
