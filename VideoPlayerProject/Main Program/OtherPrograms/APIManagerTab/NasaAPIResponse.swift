//
//  NasaAPIResponse.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-15.
//

import Foundation

struct NasaAPIResponse: Codable {
    
    let links: Link
    let element_count: Int
    let near_earth_objects: Objects
    
    struct Link: Codable {
        private enum CodingKeys: String, CodingKey { case next = "next", prev = "prev", itself = "self"}
        let next: String
        let prev: String
        let itself: String
    }
    
    struct Objects: Codable {
        private enum CodingKeys: String, CodingKey { case date1 = "2015-09-08", date2 = "2015-09-07" }
        
        let date1: [Asteroid]
        let date2: [Asteroid]
        
        struct Asteroid: Codable {
            let links: Single_link
            let id: String
            let neo_reference_id: String
            let name: String
            let nasa_jpl_url: String
            let absolute_magnitude_h: Double
            let estimated_diameter: Diameter
            let is_potentially_hazardous_asteroid: Bool
            let close_approach_data: [Astroid_Data]
            let is_sentry_object: Bool

            struct Single_link: Codable {
                private enum CodingKeys: String, CodingKey { case itself = "self" }
                let itself: String
            }

            struct Diameter: Codable {
                let kilometers: min_max
                let meters: min_max
                let miles: min_max
                let feet: min_max

                struct min_max: Codable {
                    let estimated_diameter_min: Double
                    let estimated_diameter_max: Double
                }
            }

            struct Astroid_Data: Codable {
                let close_approach_date: String
                let close_approach_date_full: String
                let epoch_date_close_approach: Int
                let relative_velocity: Velocity
                let miss_distance: Distance
                let orbiting_body: String

                struct Velocity: Codable {
                    let kilometers_per_second: String
                    let kilometers_per_hour: String
                    let miles_per_hour: String
                }

                struct Distance: Codable {
                    let astronomical: String
                    let lunar: String
                    let kilometers: String
                    let miles: String
                }
            }
        }
    }
    
    
}




