//
//  OtherProgramsViewController.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-02.
//

import UIKit

class OtherProgramsViewController: UIViewController {
    
    @IBOutlet weak var otherPrograms: UICollectionView!
    private var programs: [OtherProgramNames] = [.Login, .APIManager, .PopUpMessage, .LogInPageRapsodo, .SingUpPageRapsodo, .PreferencesWithUserDefaults]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(rightSwipe)
        
        otherPrograms.register(ProgramCollectionViewCell.self, forCellWithReuseIdentifier: "ProgramCollectionViewCell")
        self.otherPrograms.delegate = self
        self.otherPrograms.dataSource = self
        self.otherPrograms.reloadData()
        
        self.otherPrograms.backgroundColor =  UIColor.systemGray6
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        self.tabBarController!.selectedIndex -= 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension OtherProgramsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if programs[indexPath.row] == .Login {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
            controller.hidesBottomBarWhenPushed = true
            navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationController?.pushViewController(controller, animated: true)
        } else if programs[indexPath.row] == .APIManager {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "APIManagerViewController") as! APIManagerViewController
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        } else if programs[indexPath.row] == .PopUpMessage {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "PopUPMessageViewController") as! PopUPMessageViewController
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        } else if programs[indexPath.row] == .LogInPageRapsodo {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "LogInPageSwiftUI")
            controller!.hidesBottomBarWhenPushed = true
            navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationController?.pushViewController(controller!, animated: true)
        } else if programs[indexPath.row] == .SingUpPageRapsodo {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "SignUpPageSwiftUI")
            controller!.hidesBottomBarWhenPushed = true
            navigationController?.setNavigationBarHidden(true, animated: true)
            self.navigationController?.pushViewController(controller!, animated: true)
        } else if programs[indexPath.row] == .PreferencesWithUserDefaults {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "PreferencesWithUserDefaultsSwiftUI")
            controller!.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller!, animated: true)
        }
    }
}

extension OtherProgramsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return programs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgramCollectionViewCell", for: indexPath) as! ProgramCollectionViewCell
        cell.setTitle(programs[indexPath.row].rawValue)
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemGray3.cgColor
        cell.layer.backgroundColor = UIColor.white.cgColor
        return cell
    }
}

extension OtherProgramsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 8, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 15, left: 4, bottom: 15, right: 4)
    }
}
