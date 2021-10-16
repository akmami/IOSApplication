//
//  EditAndViewProfileController.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-21.
//

import UIKit
import CoreData

class EditAndViewProfileController: UIViewController {
    
    // Delegate
    var controllerType: ViewControllerType? = nil {
        didSet {
            if controllerType == .view {
                nameTextView.isEditable = false
                surnameTextView.isEditable = false
                maleGenderBtn.isEnabled = false
                femaleGenderBtn.isEnabled = false
                aboutTextView.isEditable = false
            }
        }
    }
    
    // UI components and other variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let nameLabel = UILabel()
    let nameTextView = UITextView()
    let surnameLabel = UILabel()
    let surnameTextView = UITextView()
    let genderLabel = UILabel()
    let userGenderLabelForViewMode = UILabel()
    let maleGenderBtn = UIButton()
    let femaleGenderBtn = UIButton()
    let hobbiesLabel = UILabel()
    let displayHobbiesBtn = UIButton()
    let addHobbyInputTextView = UITextView()
    let addHobby = UIButton()
    let allHobbiesTableView = UITableView()
    let aboutLabel = UILabel()
    let aboutTextView = UITextView()
    let currentNumberOfCharecterLabel = UILabel()
    let cancelBtn = UIButton()
    let saveBtn = UIButton()
    
    let currentNumberOfCharectersInAboutTextView = 0
    var profile: Profile?
    var spacingBetweenBorder: CGFloat = 20
    var gender: Gender = .notSpecified
    var viewDidLayoutSubviewsType: ViewLoadType = .redrawContent
    var isHobbiesExpanded: Bool = false {
        didSet {
            if isViewLoaded {
                if(isHobbiesExpanded) {
                    let row = (allHobbiesTableView.visibleCells[0] as UITableViewCell).bounds.height
                    let hobbiesCount = profile?.hobi?.count ?? 0
                    self.hobbiesTableViewHeightConstraint?.constant = CGFloat(hobbiesCount) * row
                } else {
                    self.hobbiesTableViewHeightConstraint?.constant = 0
                }
                viewDidLayoutSubviewsType = .redrawContent
                self.view.layoutIfNeeded()
            }
        }
    }
    var hobbiesTableViewHeightConstraint: NSLayoutConstraint?
    
    // IBOutlet variables
    @IBOutlet weak var profilePageScrollView: UIView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if viewDidLayoutSubviewsType == .changeSingleView {
            return ;
        }
        viewDidLayoutSubviewsType = .changeSingleView
        
        createNameLabelAndView()
        createSurnameLabelAndView()
        if controllerType == .edit {
            setGenderLabelAndButtonsInEditMode()
        } else {
            setGenderLabelAndButtonsInViewMode()
        }
        createHobbyLabelAndCollectionView()
        createAboutLabelAndView()
        createCancelAndSaveButtons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request: NSFetchRequest<Profile> = Profile.fetchRequest()
        let profiles = (try? self.context.fetch(request))
        
        if profiles!.count == 0 {
            showAlert("There is no account in CoreData. Please create one in New Profile page.", completion: {
                self.navigationController?.popViewController(animated: true)
                print("navigation is poped")
            })
            return ;
        }
        
        self.profile = profiles![0]

        if profile?.gender == "male" {
            gender = .male
        } else if profile?.gender == "female" {
            gender = .female
        }
        hobbiesTableViewHeightConstraint = NSLayoutConstraint(item: allHobbiesTableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
//        allHobbiesTableView.register(CustomHobbyViewTableCell.self, forCellReuseIdentifier: "CustomHobbyViewTableCell")
        
    }
    
    func createNameLabelAndView() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextView.translatesAutoresizingMaskIntoConstraints = false
        profilePageScrollView.addSubview(nameLabel)
        profilePageScrollView.addSubview(nameTextView)
        
        nameLabel.topAnchor.constraint(equalTo: profilePageScrollView.topAnchor, constant: 50).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: profilePageScrollView.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: nameTextView.leadingAnchor, constant: -10).isActive = true
        
        nameLabel.widthAnchor.constraint(equalToConstant: (profilePageScrollView.frame.width - 50) / 3).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameTextView.topAnchor.constraint(equalTo: profilePageScrollView.topAnchor, constant: 50).isActive = true
        
        nameTextView.widthAnchor.constraint(equalToConstant: (profilePageScrollView.frame.width - 50) / 3).isActive = true
        nameTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameLabel.textAlignment = .right
        nameLabel.textColor = .black
        nameLabel.text = "Name"
        nameTextView.layer.cornerRadius = 5
        nameTextView.layer.borderWidth = 1
        nameTextView.layer.borderColor = UIColor.gray.cgColor
        nameTextView.textContainer.maximumNumberOfLines = 1
        nameTextView.text = profile?.name
    }
    
    func createSurnameLabelAndView() {
        surnameLabel.translatesAutoresizingMaskIntoConstraints = false
        surnameTextView.translatesAutoresizingMaskIntoConstraints = false
        profilePageScrollView.addSubview(surnameLabel)
        profilePageScrollView.addSubview(surnameTextView)
        
        surnameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        surnameLabel.leadingAnchor.constraint(equalTo: profilePageScrollView.leadingAnchor, constant: 20).isActive = true
        surnameLabel.trailingAnchor.constraint(equalTo: surnameTextView.leadingAnchor, constant: -10).isActive = true
        
        surnameLabel.widthAnchor.constraint(equalToConstant: (profilePageScrollView.frame.size.width - 50) / 3).isActive = true
        surnameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        surnameTextView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: spacingBetweenBorder).isActive = true
        surnameTextView.widthAnchor.constraint(equalToConstant: (profilePageScrollView.frame.size.width - 50) / 3).isActive = true
        surnameTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        surnameLabel.textAlignment = .right
        surnameLabel.text = "Surname"
        surnameTextView.layer.cornerRadius = 5
        surnameTextView.layer.borderWidth = 1
        surnameTextView.layer.borderColor = UIColor.gray.cgColor
        surnameTextView.textContainer.maximumNumberOfLines = 1
        surnameTextView.text = profile?.surname
    }
    
    func setGenderLabelAndButtonsInViewMode() {
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        userGenderLabelForViewMode.translatesAutoresizingMaskIntoConstraints = false
        profilePageScrollView.addSubview(genderLabel)
        profilePageScrollView.addSubview(userGenderLabelForViewMode)
        
        genderLabel.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 20).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: profilePageScrollView.leadingAnchor, constant: 20).isActive = true
        genderLabel.trailingAnchor.constraint(equalTo: userGenderLabelForViewMode.leadingAnchor, constant: -10).isActive = true
        genderLabel.widthAnchor.constraint(equalToConstant: (profilePageScrollView.frame.size.width - 50) / 3).isActive = true
        genderLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        genderLabel.textAlignment = .right
        genderLabel.textColor = .black
        genderLabel.text = "Gender"
        
        userGenderLabelForViewMode.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 20).isActive = true
        userGenderLabelForViewMode.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userGenderLabelForViewMode.heightAnchor.constraint(equalToConstant: 30).isActive = true
        userGenderLabelForViewMode.textColor = .black
        userGenderLabelForViewMode.font = UIFont.systemFont(ofSize: 10)
        userGenderLabelForViewMode.text = gender.rawValue
    }
    
    func setGenderLabelAndButtonsInEditMode() {
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        maleGenderBtn.translatesAutoresizingMaskIntoConstraints = false
        femaleGenderBtn.translatesAutoresizingMaskIntoConstraints = false
        profilePageScrollView.addSubview(genderLabel)
        profilePageScrollView.addSubview(maleGenderBtn)
        profilePageScrollView.addSubview(femaleGenderBtn)
        // Gender Label
        genderLabel.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 20).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: profilePageScrollView.leadingAnchor, constant: 20).isActive = true
        genderLabel.trailingAnchor.constraint(equalTo: femaleGenderBtn.leadingAnchor, constant: -10).isActive = true
        
        genderLabel.widthAnchor.constraint(equalToConstant: (profilePageScrollView.frame.size.width - 50) / 3).isActive = true
        genderLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Female Button
        femaleGenderBtn.topAnchor.constraint(equalTo: surnameTextView.bottomAnchor, constant: spacingBetweenBorder).isActive = true
        femaleGenderBtn.trailingAnchor.constraint(equalTo: maleGenderBtn.leadingAnchor, constant: -10).isActive = true
        femaleGenderBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        femaleGenderBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Male Button
        maleGenderBtn.topAnchor.constraint(equalTo: surnameTextView.bottomAnchor, constant: spacingBetweenBorder).isActive = true
        maleGenderBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        maleGenderBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        genderLabel.textAlignment = .right
        genderLabel.text = "Gender"
        
        femaleGenderBtn.layer.borderWidth = 1
        femaleGenderBtn.layer.cornerRadius = 5
        femaleGenderBtn.setTitle("Female", for: .normal)
        femaleGenderBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        
        maleGenderBtn.layer.borderWidth = 1
        maleGenderBtn.layer.cornerRadius = 5
        maleGenderBtn.setTitle("Male", for: .normal)
        maleGenderBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        
        if gender == .male {
            maleGenderBtn.layer.borderColor = UIColor.green.cgColor
            maleGenderBtn.setTitleColor(.green, for: .normal)
            femaleGenderBtn.layer.borderColor = UIColor.gray.cgColor
            femaleGenderBtn.setTitleColor(.gray, for: .normal)
        } else {
            maleGenderBtn.layer.borderColor = UIColor.gray.cgColor
            maleGenderBtn.setTitleColor(.gray, for: .normal)
            femaleGenderBtn.layer.borderColor = UIColor.green.cgColor
            femaleGenderBtn.setTitleColor(.green, for: .normal)
        }
        maleGenderBtn.addTarget(self, action: #selector(maleIsClicked), for: .touchUpInside)
        femaleGenderBtn.addTarget(self, action: #selector(femaleIsClicked), for: .touchUpInside)
    }
    
    func createHobbyLabelAndCollectionView() {
        if validateHobbiesExistance() == false {
            return ;
        }
        
        allHobbiesTableView.translatesAutoresizingMaskIntoConstraints = false
        hobbiesLabel.translatesAutoresizingMaskIntoConstraints = false
        displayHobbiesBtn.translatesAutoresizingMaskIntoConstraints = false
        allHobbiesTableView.tableFooterView = UIView()
        profilePageScrollView.addSubview(allHobbiesTableView)
        profilePageScrollView.addSubview(hobbiesLabel)
        profilePageScrollView.addSubview(displayHobbiesBtn)
    
        
        hobbiesLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20).isActive = true
        hobbiesLabel.leadingAnchor.constraint(equalTo: profilePageScrollView.leadingAnchor, constant: 20).isActive = true
        hobbiesLabel.trailingAnchor.constraint(equalTo: displayHobbiesBtn.leadingAnchor, constant: -10).isActive = true
        
        hobbiesLabel.widthAnchor.constraint(equalToConstant: (profilePageScrollView.frame.width - 50) / 3).isActive = true
        hobbiesLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        displayHobbiesBtn.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20).isActive = true
        
        displayHobbiesBtn.widthAnchor.constraint(equalToConstant: (profilePageScrollView.frame.width - 50) / 3).isActive = true
        displayHobbiesBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true

        allHobbiesTableView.topAnchor.constraint(equalTo: displayHobbiesBtn.bottomAnchor, constant: 0).isActive = true
        allHobbiesTableView.leadingAnchor.constraint(equalTo: displayHobbiesBtn.leadingAnchor).isActive = true
        allHobbiesTableView.widthAnchor.constraint(equalToConstant: (profilePageScrollView.frame.width - 50) * 2 / 3).isActive = true
        
        allHobbiesTableView.addConstraint(hobbiesTableViewHeightConstraint!)
        allHobbiesTableView.dataSource = self
        allHobbiesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        hobbiesLabel.textAlignment = .right
        hobbiesLabel.text = "Hobbies"
        
        displayHobbiesBtn.layer.borderWidth = 1
        displayHobbiesBtn.layer.cornerRadius = 5
        displayHobbiesBtn.setTitle(" ↓ Display all Hobbies", for: .normal)
        displayHobbiesBtn.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        displayHobbiesBtn.setTitleColor(.gray, for: .normal)
        displayHobbiesBtn.addTarget(self, action: #selector(displayHobbieBtnIsClicked), for: .touchUpInside)
    }
    
    func createAboutLabelAndView() {
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutTextView.translatesAutoresizingMaskIntoConstraints = false
        currentNumberOfCharecterLabel.translatesAutoresizingMaskIntoConstraints = false
        profilePageScrollView.addSubview(aboutLabel)
        profilePageScrollView.addSubview(aboutTextView)
        profilePageScrollView.addSubview(currentNumberOfCharecterLabel)
        
        if validateHobbiesExistance() == true { // also modify according to the expanded hobbies
            aboutLabel.topAnchor.constraint(equalTo: allHobbiesTableView.bottomAnchor, constant: 20).isActive = true
            aboutTextView.topAnchor.constraint(equalTo: allHobbiesTableView.bottomAnchor, constant: 20).isActive = true
        } else {
            aboutLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20).isActive = true
            aboutTextView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 20).isActive = true
        }
        aboutLabel.leadingAnchor.constraint(equalTo: profilePageScrollView.leadingAnchor, constant: 20).isActive = true
        aboutLabel.trailingAnchor.constraint(equalTo: aboutTextView.leadingAnchor, constant: -10).isActive = true
        
        aboutLabel.widthAnchor.constraint(equalToConstant: (profilePageScrollView.frame.size.width - 50) / 3).isActive = true
        aboutLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        aboutTextView.widthAnchor.constraint(equalToConstant: (profilePageScrollView.frame.size.width - 50) / 3).isActive = true
        aboutTextView.heightAnchor.constraint(equalToConstant: 210).isActive = true
        
        currentNumberOfCharecterLabel.topAnchor.constraint(equalTo: aboutTextView.bottomAnchor, constant: 5).isActive = true
        currentNumberOfCharecterLabel.trailingAnchor.constraint(equalTo: aboutTextView.trailingAnchor).isActive = true
        
        currentNumberOfCharecterLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        currentNumberOfCharecterLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        aboutLabel.textAlignment = .right
        aboutLabel.text = "About"
        aboutTextView.layer.cornerRadius = 5
        aboutTextView.layer.borderWidth = 1
        aboutTextView.layer.borderColor = UIColor.gray.cgColor
        aboutTextView.textColor = .black
        if profile?.about != nil {
            aboutTextView.text = profile?.about

        }
        currentNumberOfCharecterLabel.textAlignment = .right
        currentNumberOfCharecterLabel.font = UIFont.systemFont(ofSize: 10)
        currentNumberOfCharecterLabel.textColor = UIColor.systemGray2
        currentNumberOfCharecterLabel.text = aboutTextView.text.count.description
        aboutTextView.delegate = self
    }
    
    func createCancelAndSaveButtons() {
        if controllerType != .edit {
            print("not edit mode.")
            return ;
        }
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        profilePageScrollView.addSubview(cancelBtn)
        profilePageScrollView.addSubview(saveBtn)
        
        saveBtn.topAnchor.constraint(equalTo: currentNumberOfCharecterLabel.bottomAnchor, constant: 15).isActive = true
        saveBtn.trailingAnchor.constraint(equalTo: currentNumberOfCharecterLabel.trailingAnchor).isActive = true
        
        saveBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        saveBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        cancelBtn.topAnchor.constraint(equalTo: currentNumberOfCharecterLabel.bottomAnchor, constant: 15).isActive = true
        cancelBtn.trailingAnchor.constraint(equalTo: saveBtn.leadingAnchor, constant: -10).isActive = true
        
        cancelBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cancelBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        saveBtn.layer.cornerRadius = 10
        saveBtn.setTitleColor(.white, for: .normal)
        saveBtn.backgroundColor = .green
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        saveBtn.addTarget(self, action: #selector(saveButtonIsClicked), for: .touchUpInside)
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.setTitleColor(.white, for: .normal)
        cancelBtn.backgroundColor = .gray
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        cancelBtn.addTarget(self, action: #selector(cancelButtonIsClicked), for: .touchUpInside)
    }
    
    func validateHobbiesExistance() -> Bool {
        if profile?.hobi == nil {
            print("profile?.hobi is nil.")
            return false
        }
        guard let hobbies = (profile?.hobi!) else {
            print("Failed to fetch hobbies")
            return false
        }

        if hobbies.count == 0 {
            print("No hobbies inside.")
            return false
        }
        
        return true
    }
    
    @objc func displayHobbieBtnIsClicked(_ sender: Any) {
        isHobbiesExpanded = !isHobbiesExpanded
    }
    
    @objc func maleIsClicked(_ sender: Any) {
        gender = .male
        femaleGenderBtn.layer.borderColor = UIColor.gray.cgColor
        femaleGenderBtn.setTitleColor(.gray, for: .normal)
        maleGenderBtn.layer.borderColor = UIColor.green.cgColor
        maleGenderBtn.setTitleColor(.green, for: .normal)
    }
    
    @objc func femaleIsClicked(_ sender: Any) {
        gender = .female
        maleGenderBtn.layer.borderColor = UIColor.gray.cgColor
        maleGenderBtn.setTitleColor(.gray, for: .normal)
        femaleGenderBtn.layer.borderColor = UIColor.green.cgColor
        femaleGenderBtn.setTitleColor(.green, for: .normal)
    }
    
    @objc func saveButtonIsClicked(_ sender: Any) {
        
        let name = nameTextView.text!
        let surname = surnameTextView.text!
        let about = aboutTextView.text!
        
        if name.count == 0 || name.trimmingCharacters(in: .whitespaces).count == 0 {
            showAlert("Name cannot be leaved empty. Please enter name.", completion: {})
            return
        }
        
        if surname.count == 0 || surname.trimmingCharacters(in: .whitespaces).count == 0 {
            showAlert("Surname cannot be leaved empty. Please enter surname.", completion: {})
            return
        }
        
        if gender == .notSpecified {
            showAlert("Please specify gender.", completion: {})
            return
        }
        
        // Validate the name
        let predicateNameTest = NSPredicate(format: "SELF MATCHES %@", "[a-z]*")
        if !predicateNameTest.evaluate(with: name) {
            showAlert("The name is invalid. Please enter valid name.", completion: {})
            return
        }

        // Validate the surname
        if !predicateNameTest.evaluate(with: surname) {
            showAlert("The surname is invalid. Please enter valid surname.", completion: {})
            return
        }
        
        
        let updateProfile = profile! as NSManagedObject
        updateProfile.setValue(name, forKey: "name")
        updateProfile.setValue(surname, forKey: "surname")
        updateProfile.setValue(gender.rawValue, forKey: "gender")
        updateProfile.setValue(about.trimmingCharacters(in: .whitespaces), forKey: "about")
        
        do {
            try self.context.save()
            showAlert("You have succesfully updated current account.", completion: {
                self.navigationController?.popViewController(animated: true)
            })
        } catch {
            print("Unable to update profile(save)")
            return
        }
    }
    
    @objc func cancelButtonIsClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showAlert(_ message: String, completion: @escaping () -> Void) {
        let dialogMessage = UIAlertController(title: "Profile Information", message: message, preferredStyle: .alert)
        dialogMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completion()
        }))
        self.present(dialogMessage, animated: true, completion: {})
    }
}

// MARK: - Extension of Delegate Protocol
extension EditAndViewProfileController: ViewEditDelegateProtocol {
    func setType(_ type: ViewControllerType) {
        controllerType = type
    }
}

// MARK: - UITextView related functions
extension EditAndViewProfileController: UITextViewDelegate {
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
        if newTextCount <= 300 {
            currentNumberOfCharecterLabel.text = (300 - newTextCount).description
            return true
        }
        return false;
    }
}

// MARK: - extension of UITableViewDataSource
extension EditAndViewProfileController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile?.hobi?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = allHobbiesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        cell.textLabel?.text = profile?.hobi?[indexPath.row]
        return cell
    }
    
    @objc func deleteHobby(sender: CustomTapGestureRecognizer) {
        
    }

}
