//
//  UserSettings.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-29.
//

import Combine
import Foundation

class UserSettings: ObservableObject {
    
    @Published var name: String {
        didSet {
            UserDefaults.standard.set(name, forKey: "name")
        }
    }
    @Published var surname: String {
        didSet {
            UserDefaults.standard.set(surname, forKey: "surname")
        }
    }
    @Published var email: String {
        didSet {
            UserDefaults.standard.set(email, forKey: "email")
        }
    }
    @Published var password: String {
        didSet {
            UserDefaults.standard.set(password, forKey: "password")
        }
    }
    @Published var number: String {
        didSet {
            UserDefaults.standard.set(number, forKey: "number")
        }
    }
    @Published var age: String {
        didSet {
            UserDefaults.standard.set(age, forKey: "age")
        }
    }
    @Published var gender: String {
        didSet {
            UserDefaults.standard.set(gender, forKey: "gender")
        }
    }
    @Published var weight: String {
        didSet {
            UserDefaults.standard.set(weight, forKey: "weight")
        }
    }
    @Published var hobbies: String {
        didSet {
            UserDefaults.standard.set(hobbies, forKey: "hobbies")
        }
    }
    @Published var heighest_scores: String {
        didSet {
            UserDefaults.standard.set(heighest_scores, forKey: "heighest_scores")
        }
    }
    
    init() {
        self.name = UserDefaults.standard.object(forKey: "name") as? String ?? ""
        self.surname = UserDefaults.standard.object(forKey: "surname") as? String ?? ""
        self.email = UserDefaults.standard.object(forKey: "email") as? String ?? ""
        self.password = UserDefaults.standard.object(forKey: "password") as? String ?? ""
        self.number = UserDefaults.standard.object(forKey: "number") as? String ?? ""
        self.age = UserDefaults.standard.object(forKey: "age") as? String ?? ""
        self.gender = UserDefaults.standard.object(forKey: "gender") as? String ?? ""
        self.weight = UserDefaults.standard.object(forKey: "weight") as? String ?? ""
        self.hobbies = UserDefaults.standard.object(forKey: "hobbies") as? String ?? ""
        self.heighest_scores = UserDefaults.standard.object(forKey: "heighest_scores") as? String ?? ""
    }
}

