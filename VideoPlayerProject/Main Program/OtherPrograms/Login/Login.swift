//
//  Login.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-03.
//

import SwiftUI
import UIKit
import CoreData

class Login: UIView {
    
    var items: [Account]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let viewFromXib = Bundle.main.loadNibNamed("Login", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.frame
        addSubview(viewFromXib)
        
        // Other initializations
        commonInit()
    }
    
    func commonInit() {
        self.loginBtn.setTitle("Login", for: UIControl.State.normal)            // Set title for the button
        self.loginBtn.layer.cornerRadius = self.loginBtn.bounds.size.height/2;  // Set corders for the button
        self.passwordTxt.isSecureTextEntry = true                               // Hide the password
        
        // Add gesture that hides the keyboard whenever the user taps outside the keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector((UIInputViewController.dismissKeyboard)))
        self.addGestureRecognizer(tap)
        fetchAccounts()
        
        if items!.count == 0 {
            addAccount("akmami", "12345")
        }
        print("All account in CoreData is:")
        for item in items! {
            print(item.username! + " " + item.password!)
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let username = usernameTxt.text, !username.isEmpty else {
            print("No input is entered to the UITextField")
            passwordTxt.text = ""
            return
        }
        guard let password = passwordTxt.text, !password.isEmpty else {
            print("No password is entered to the UITextField")
            return
        }
        let accounts = queryAccount(username)
        var message: String
        if(accounts.count > 0) {
            if accounts[0].password == password {
                message = "Account with username \"" + accounts[0].username! + "\" and pasword \"" + accounts[0].password! + "\" is exists."
            } else {
                message = "Invalid password"
            }
            
        } else {
            message = "Account with username \"" + username + "\" does not exists."
            
        }
        dismissKeyboard()
        showAlert(message, popUpViewController: true)
    }
    
    func showAlert(_ message: String, popUpViewController: Bool) {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                // Create and show alert
                let dialogMessage = UIAlertController(title: "Login Information", message: message, preferredStyle: .alert)
                dialogMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    viewController.navigationController?.popViewController(animated: true)
                    print("navigation is poped")
                }))
                viewController.present(dialogMessage, animated: true, completion: {})
            }
        }
    }
    
    func isAccountExist(_ username: String) -> Bool{
        if queryAccount(username).count == 0 {
            return false
        }
        return true
    }
    
    func queryAccount(_ username: String, _ password: String) -> [Account] {
        let request: NSFetchRequest<Account> = Account.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        let accounts = (try? self.context.fetch(request)) ?? []
        return accounts
    }
    
    func queryAccount(_ username: String) -> [Account] {
        let request: NSFetchRequest<Account> = Account.fetchRequest()
        request.predicate = NSPredicate(format: "username == %@", username)
        let accounts = (try? self.context.fetch(request)) ?? []
        return accounts
    }
    
    func removeAccount(_ username: String, _ index: Int) -> Bool {
        let accountToDelete = self.items![index]    // where 0 is the location of the account in array
                                                    // I have added index since there is only 1 account in CoreData
        self.context.delete(accountToDelete)
        do {
            try context.save()
        } catch {
            print("Error to delete person(delete)")
            return false
        }
        self.fetchAccounts()
        return true
    }
    
    
    func addAccount(_ username: String, _ password: String) -> Bool {
        if isAccountExist(username) {
            print("Account already exist.")
            return false
        }
        let newAccount = Account(context: self.context)
        newAccount.username = username
        newAccount.password = password
        do {
            try self.context.save()
        } catch {
            print("Unable to upload person(save)")
            return false
        }
        self.fetchAccounts()
        return true
    }
    
    func fetchAccounts() {
        do {
            self.items = try self.context.fetch(Account.fetchRequest())
        } catch {
            print("Unable to fetch accounts.")
        }
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}
