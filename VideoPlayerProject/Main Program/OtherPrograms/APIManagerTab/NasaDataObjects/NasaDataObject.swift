//
//  NasaDataObject.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-16.
//

import Foundation
import RealmSwift

class NasaDataObject: Object {
    
    @objc dynamic var links: Link?
    var element_count = RealmOptional<Int>()
    @objc dynamic var near_earth_objects: CelestialBodies?

    func setParameters(_ nasaAPI: NasaAPIResponse) {
        if links == nil {
            links = Link()
        }
        if near_earth_objects == nil {
            near_earth_objects = CelestialBodies()
            near_earth_objects!.date1 = Asteroid()
        }
        links!.next = nasaAPI.links.next
        links!.prev = nasaAPI.links.prev
        links!.itself = nasaAPI.links.itself
        
        element_count = RealmOptional<Int>(nasaAPI.element_count)
        
        near_earth_objects!.date1!.id = nasaAPI.near_earth_objects.date1[0].id
        near_earth_objects!.date1!.neo_reference_id = nasaAPI.near_earth_objects.date1[0].neo_reference_id
        near_earth_objects!.date1!.name = nasaAPI.near_earth_objects.date1[0].name
        near_earth_objects!.date1!.nasa_jpl_url = nasaAPI.near_earth_objects.date1[0].nasa_jpl_url
        near_earth_objects!.date1!.absolute_magnitude_h = RealmOptional<Double>(nasaAPI.near_earth_objects.date1[0].absolute_magnitude_h)
        near_earth_objects!.date1!.is_potentially_hazardous_asteroid = RealmOptional<Bool>(nasaAPI.near_earth_objects.date1[0].is_potentially_hazardous_asteroid)
        near_earth_objects!.date1!.is_sentry_object = RealmOptional<Bool>(nasaAPI.near_earth_objects.date1[0].is_sentry_object)
        
//        near_earth_objects!.date2!.id = nasaAPI.near_earth_objects.date2[0].id
//        near_earth_objects!.date2!.neo_reference_id = nasaAPI.near_earth_objects.date2[0].neo_reference_id
//        near_earth_objects!.date2!.name = nasaAPI.near_earth_objects.date2[0].name
//        near_earth_objects!.date2!.nasa_jpl_url = nasaAPI.near_earth_objects.date2[0].nasa_jpl_url
//        near_earth_objects!.date2!.absolute_magnitude_h = nasaAPI.near_earth_objects.date2[0].absolute_magnitude_h as NSNumber
//        near_earth_objects!.date2!.is_potentially_hazardous_asteroid = nasaAPI.near_earth_objects.date2[0].is_potentially_hazardous_asteroid as NSNumber
//        near_earth_objects!.date2!.is_sentry_object = nasaAPI.near_earth_objects.date2[0].is_sentry_object as NSNumber
    }
}
