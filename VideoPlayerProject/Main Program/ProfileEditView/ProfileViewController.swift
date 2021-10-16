//
//  ProfileViewController.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var newProfileBtn: UIButton!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var viewProfileBtn: UIButton!
    
    var delegate: ViewEditDelegateProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if sender.direction == .left {
            self.tabBarController!.selectedIndex += 1
        }
        if sender.direction == .right {
            self.tabBarController!.selectedIndex -= 1
        }
    }
    
    @IBAction func newProfileBtnClicked(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(identifier: "NewProfileController") as! NewProfileController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func editProfileBtnClicked(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(identifier: "EditAndViewProfileController") as! EditAndViewProfileController
        self.delegate = controller
        self.delegate?.setType(.edit)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func viewProfileBtnClicked(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(identifier: "EditAndViewProfileController") as! EditAndViewProfileController
        self.delegate = controller
        self.delegate?.setType(.view)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
