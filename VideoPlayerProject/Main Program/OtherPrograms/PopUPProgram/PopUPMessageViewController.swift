//
//  PopUPMessageViewController.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-07-02.
//

import UIKit

class PopUPMessageViewController: UIViewController {
    
    var grayCoverView: UIView?
    @IBOutlet weak var selectedItemsCollectionView: UICollectionView!
    var selectedItems: [[SelectionInPopUP]] = [[SelectionInPopUP]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedItemsCollectionView.register(PopUpCustomCollectionViewCell.self, forCellWithReuseIdentifier: "PopUpCustomCollectionViewCell")
        selectedItems.append([.Baseball, .Bicycle])
        self.selectedItemsCollectionView.delegate = self
        self.selectedItemsCollectionView.dataSource = self
        self.selectedItemsCollectionView.reloadData()
        
        self.selectedItemsCollectionView.backgroundColor =  UIColor.systemGray6
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func navigateToPopUpController(_ sender: Any) {
        grayCoverView = UIView(frame: UIScreen.main.bounds)
        grayCoverView!.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.addSubview(grayCoverView!)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChooseActivityPopUPViewController") as! ChooseActivityPopUPViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension PopUPMessageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopUpCustomCollectionViewCell", for: indexPath) as! PopUpCustomCollectionViewCell

        cell.setItems(items: selectedItems[indexPath.row], indexPath: indexPath.row)
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemGray4.cgColor
        cell.backgroundColor = UIColor.white
        
        return cell
    }
}

extension PopUPMessageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lengthForEachItemInCell = 30
        let totalHeightOfCell = lengthForEachItemInCell * (selectedItems[indexPath.row].count)
        return CGSize(width: self.view.frame.width - 4, height: CGFloat(totalHeightOfCell))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 15, left: 2, bottom: 15, right: 2)
    }
}

extension PopUPMessageViewController: AddSelectionsDelegate {
    
    func addSelections(selections: [SelectionInPopUP]) {
        self.dismiss(animated: true) {
            if self.grayCoverView != nil {
                self.grayCoverView!.removeFromSuperview()
                self.grayCoverView = nil
            }
            if selections == [] {
                return
            }
            self.selectedItems.append(selections)
            self.selectedItemsCollectionView.reloadData()
        }
    }
}
