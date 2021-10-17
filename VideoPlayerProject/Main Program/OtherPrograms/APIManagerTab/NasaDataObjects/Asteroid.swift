//
//  Asteroid.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-18.
//

import Foundation
import RealmSwift

class Asteroid: Object {
    @objc dynamic var id: String?
    @objc dynamic var neo_reference_id: String?
    @objc dynamic var name: String?
    @objc dynamic var nasa_jpl_url: String?
    var absolute_magnitude_h = RealmOptional<Double>()
    var is_potentially_hazardous_asteroid = RealmOptional<Bool>()
    var is_sentry_object = RealmOptional<Bool>()
}
