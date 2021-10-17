//
//  APIManagerViewController.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-16.
//

import SwiftUI
import RealmSwift
import UIKit

class APIManagerViewController: UIViewController {
    
    @IBOutlet weak var setToRealmBtn: UIButton!
    @IBOutlet weak var getFromRealmBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setToRealmBtn.layer.cornerRadius = 5
        getFromRealmBtn.layer.cornerRadius = 5
    }

    
    @IBAction func retrieveFromRealmAndPrint(_ sender: Any) {
        let realm = try! Realm()
        let results = realm.objects(NasaDataObject.self)
////        let results = realm.objects(NasaAPI.self).filter("id = %@", 24656342)
        for result in results {
            print("-----------------------------------")
            print("link-self: " + result.links!.itself!)
            print("element_count: " + result.element_count.value!.description)
            print("\nAsteroid")
            print("id: " + result.near_earth_objects!.date1!.id!)
            print("neo_reference_id: " + result.near_earth_objects!.date1!.neo_reference_id!)
            print("name: " + result.near_earth_objects!.date1!.name!)
            print("nasa_jpl_url: " + result.near_earth_objects!.date1!.nasa_jpl_url!)
            print("absolute_magnitude_h: " + result.near_earth_objects!.date1!.absolute_magnitude_h.value!.description)
            print("is_potentially_hazardous_asteroid: " + result.near_earth_objects!.date1!.is_potentially_hazardous_asteroid.value!.description)
            print("is_sentry_object: " + result.near_earth_objects!.date1!.is_sentry_object.value!.description)
        }
        print("retrieveFromRealmAndPrint")
    }
    
    @IBAction func getFormNasaAndSetToRealm(_ sender: Any) {
        let rest = APIManager()
        let nasaAPI = "d8Dbk7nuvZ0TYkfy7kiONNR6rjLYKOFO4rfRsHe7"
        let start_date = "2015-09-07"
        let end_date = "2015-09-08"
        let url = "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(start_date)&end_date=\(end_date)&api_key=\(nasaAPI)"
        guard let urlRequest = URL(string: url) else { return }
        rest.getData(fromURL: urlRequest){ (returnData) in
            if let data = returnData {
                let decoder = JSONDecoder()

                guard let nasaData = try? decoder.decode(NasaAPIResponse.self, from: data) else { return }
                let nasaObject = NasaDataObject()
                nasaObject.setParameters(nasaData)

                let realm = try! Realm()
                do {
                    try realm.write {
                        realm.add(nasaObject)
                        print("data is added to realm")
                    }
                }
                catch {
                    print("error: \(error.localizedDescription)")
                }
            }
        }
        print("getFormNasaAndSetToRealm")
    }
}
