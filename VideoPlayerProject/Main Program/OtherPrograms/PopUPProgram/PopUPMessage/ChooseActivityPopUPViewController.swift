//
//  ChooseActivityPopUPViewController.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-05.
//

import UIKit
import SwiftUI

class ChooseActivityPopUPViewController: UIViewController {
    
    var delegate: AddSelectionsDelegate?
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var popUpTitle: UILabel! {
        didSet {
            popUpTitle.numberOfLines = 2
            popUpTitle.lineBreakMode = .byWordWrapping
        }
    }
    @IBOutlet weak var bicycleBtn: CustomSelectionButton!
    @IBOutlet weak var baseballBtn: CustomSelectionButton!
    @IBOutlet weak var golfBtn: CustomSelectionButton!
    @IBOutlet weak var basketballBtn: CustomSelectionButton!
    @IBOutlet weak var confirmBtn: UIButton!
    var selectedItems: [SelectionInPopUP] = [SelectionInPopUP]() {
        didSet {
            if selectedItems.count > 0 {
                confirmBtn.backgroundColor = UIColor.orange
                confirmBtn.isEnabled = true
            } else {
                confirmBtn.backgroundColor = UIColor.systemGray3
                confirmBtn.isEnabled = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isOpaque = false
        view.backgroundColor = .clear
        
        popUpView!.layer.cornerRadius = 10
        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizerDown.direction = .down
        view.addGestureRecognizer(swipeGestureRecognizerDown)
        
        basketballBtn.translatesAutoresizingMaskIntoConstraints = false
        basketballBtn.layer.cornerRadius = basketballBtn.frame.height / 2
        basketballBtn.layer.borderWidth = 1
        basketballBtn.layer.borderColor = UIColor.black.cgColor
        basketballBtn.backgroundColor = .none
        basketballBtn.isOpaque = false
        basketballBtn.contentMode = .scaleAspectFit
        
        bicycleBtn.translatesAutoresizingMaskIntoConstraints = false
        bicycleBtn.layer.cornerRadius = bicycleBtn.frame.height / 2
        bicycleBtn.layer.borderWidth = 1
        bicycleBtn.layer.borderColor = UIColor.black.cgColor
        bicycleBtn.backgroundColor = .none
        bicycleBtn.isOpaque = false
        bicycleBtn.contentMode = .scaleAspectFit
        
        baseballBtn.translatesAutoresizingMaskIntoConstraints = false
        baseballBtn.layer.cornerRadius = basketballBtn.frame.height / 2
        baseballBtn.layer.borderWidth = 1
        baseballBtn.layer.borderColor = UIColor.black.cgColor
        baseballBtn.backgroundColor = .none
        baseballBtn.isOpaque = false
        baseballBtn.contentMode = .scaleAspectFit
        
        golfBtn.translatesAutoresizingMaskIntoConstraints = false
        golfBtn.layer.cornerRadius = golfBtn.frame.height / 2
        golfBtn.layer.borderWidth = 1
        golfBtn.layer.borderColor = UIColor.black.cgColor
        golfBtn.backgroundColor = .none
        golfBtn.isOpaque = false
        golfBtn.contentMode = .scaleAspectFit
        
        confirmBtn.translatesAutoresizingMaskIntoConstraints = false
        confirmBtn.layer.cornerRadius = confirmBtn.frame.height / 2
        confirmBtn.backgroundColor = UIColor.systemGray3
        confirmBtn.setTitleColor(.black, for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        delegate?.addSelections(selections: [])
    }
    
    @IBAction func bicycleClicked(_ sender: Any) {
        if bicycleBtn.isOn {
            removeItem(item: .Bicycle)
            bicycleBtn.isOn = false
            bicycleBtn.backgroundColor = .none
        } else {
            if selectedItems.count == 2 {
                return
            }
            selectedItems.append(.Bicycle)
            bicycleBtn.isOn = true
            bicycleBtn.backgroundColor = .yellow
        }
    }
    
    @IBAction func basballClicked(_ sender: Any) {
        if baseballBtn.isOn {
            removeItem(item: .Baseball)
            baseballBtn.isOn = false
            baseballBtn.backgroundColor = .none
        } else {
            if selectedItems.count == 2 {
                return
            }
            selectedItems.append(.Baseball)
            baseballBtn.isOn = true
            baseballBtn.backgroundColor = .yellow
        }
    }
    
    @IBAction func golfClicked(_ sender: Any) {
        if golfBtn.isOn {
            removeItem(item: .Golf)
            golfBtn.isOn = false
            golfBtn.backgroundColor = .none
        } else {
            if selectedItems.count == 2 {
                return
            }
            selectedItems.append(.Golf)
            golfBtn.isOn = true
            golfBtn.backgroundColor = .yellow
        }
    }
    
    @IBAction func basketballClicked(_ sender: Any) {
        if basketballBtn.isOn {
            removeItem(item: .Basketball)
            basketballBtn.isOn = false
            basketballBtn.backgroundColor = .none
        } else {
            if selectedItems.count == 2 {
                return
            }
            selectedItems.append(.Basketball)
            basketballBtn.isOn = true
            basketballBtn.backgroundColor = .yellow
        }
    }
    
    @IBAction func confirmClikced(_ sender: Any) {
        delegate?.addSelections(selections: selectedItems)
    }
    
    func removeItem(item: SelectionInPopUP) {
        var index = 0
        for i in selectedItems {
            if i == item {
                selectedItems.remove(at: index)
                return ;
            }
            index += 1
        }
    }
    
}
