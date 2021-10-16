//
//  NewProfileController.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-21.
//

import Foundation
import UIKit
import CoreData

class NewProfileController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var maleGenderBtn: UIButton!
    @IBOutlet weak var femaleGenderBtn: UIButton!
    @IBOutlet weak var numberOfCharectersRenamedLabel: UILabel!
    
    private var gender: Gender = .notSpecified
    let maximumNumberOfCharectrers: Int = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutTextView.delegate = self
        
        createBtn!.layer.cornerRadius = 5
        createBtn!.layer.backgroundColor = UIColor.green.cgColor
        createBtn!.setTitleColor(.white, for: .normal)
        
        maleGenderBtn!.layer.borderWidth = 1
        maleGenderBtn!.layer.cornerRadius = 5
        maleGenderBtn!.layer.borderColor = UIColor.gray.cgColor
        maleGenderBtn!.setTitleColor(.gray, for: .normal)
        
        femaleGenderBtn!.layer.borderWidth = 1
        femaleGenderBtn!.layer.cornerRadius = 5
        femaleGenderBtn!.layer.borderColor = UIColor.gray.cgColor
        femaleGenderBtn!.setTitleColor(.gray, for: .normal)
        
        numberOfCharectersRenamedLabel!.text = maximumNumberOfCharectrers.description
        numberOfCharectersRenamedLabel.textColor = .gray
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
        
        removeProfiles()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - IBAction functions
    @IBAction func createNewAccount(_ sender: Any) {
    
        // Validate that there is no account in CoreData
        let request: NSFetchRequest<Profile> = Profile.fetchRequest()
        let profiles = try? self.context.fetch(request)
        
        if profiles == nil || profiles?.count != 0 {
            let message = "You can only create 1 account, please delete that account to create new one. \n (You can delete it from Edit Profile page)"
            showAlert(message, popViewController: false)
            return
        }
        
        let name = nameTextField.text!
        let surname = surnameTextField.text!
        let about = aboutTextView.text!
        if name.count == 0 || name.trimmingCharacters(in: .whitespaces).count == 0 {
            showAlert("Name cannot be leaved empty. Please enter name.", popViewController: false)
            return
        }
        
        if surname.count == 0 || surname.trimmingCharacters(in: .whitespaces).count == 0 {
            showAlert("Surname cannot be leaved empty. Please enter surname.", popViewController: false)
            return
        }
        
        // Validate the name
        let predicateNameTest = NSPredicate(format: "SELF MATCHES %@", "[a-z]*")
        if !predicateNameTest.evaluate(with: name) {
            showAlert("The name is invalid. Please enter valid name.", popViewController: false)
            return
        }

        // Validate the surname
        if !predicateNameTest.evaluate(with: surname) {
            showAlert("The surname is invalid. Please enter valid surname.", popViewController: false)
            return
        }
        
        // Validate gender
        if gender == .notSpecified {
            showAlert("Please specify gender.", popViewController: false)
            return
        }
        
        let newProfile = Profile(context: self.context)
        newProfile.name = name.trimmingCharacters(in: .whitespaces)
        newProfile.surname = surname.trimmingCharacters(in: .whitespaces)
        newProfile.gender = gender.rawValue
        newProfile.hobi = [String]()
        newProfile.hobi?.append("reading book")
        newProfile.hobi?.append("watching movies")

        if about.count != 0 && about.trimmingCharacters(in: .whitespaces).count != 0{
            newProfile.about = about.trimmingCharacters(in: .whitespaces)
        }
        
        do {
            try self.context.save()
            showAlert("You have succesfully added new profile.", popViewController: true)
        } catch {
            print("Unable to upload profile(save)")
            return
        }
    }

    @IBAction func selectFemaleGender(_ sender: Any) {
        if gender == .male {
            maleGenderBtn!.layer.borderColor = UIColor.gray.cgColor
            maleGenderBtn!.setTitleColor(.gray, for: .normal)
        }
        femaleGenderBtn!.layer.borderColor = UIColor.green.cgColor
        femaleGenderBtn!.setTitleColor(.green, for: .normal)
        
        gender = .female
    }
    
    @IBAction func selectMaleGender(_ sender: Any) {
        if gender == .female {
            femaleGenderBtn!.layer.borderColor = UIColor.gray.cgColor
            femaleGenderBtn!.setTitleColor(.gray, for: .normal)
        }
        maleGenderBtn!.layer.borderColor = UIColor.green.cgColor
        maleGenderBtn!.setTitleColor(.green, for: .normal)
        
        gender = .male
    }
    
    // MARK: - Other functions
    func showAlert(_ message: String, popViewController: Bool) {
        let dialogMessage = UIAlertController(title: "Profile Information", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            if popViewController {
                self.navigationController?.popViewController(animated: true)
            }
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: {})
    }
    
    func removeProfiles() {
//        let request: NSFetchRequest<Profile> = Profile.fetchRequest()
//        let profiles = (try? self.context.fetch(request))
//
//        for profile in profiles! {
//            self.context.delete(profile)
//            do {
//                try context.save()
//            } catch {
//                print("error: " + error.localizedDescription)
//            }
//        }
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Profile.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try self.context.execute(deleteRequest)
        } catch {
            print("error in deletion.")
        }
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
}

// MARK: - UITextView related functions
extension NewProfileController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if aboutTextView.text.isEmpty || aboutTextView.text == "Max allowed 300 charecters" {
            aboutTextView.text = nil
            aboutTextView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if aboutTextView.text.isEmpty {
            aboutTextView.textColor = UIColor.systemGray2
            aboutTextView.text =  "Max allowed 300 charecters"
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newTextCount = (textView.text as NSString).replacingCharacters(in: range, with: text).count
        if newTextCount <= maximumNumberOfCharectrers {
            numberOfCharectersRenamedLabel!.text = (maximumNumberOfCharectrers - newTextCount).description
            return true
        }
        return false;
    }
}
