//
//  VideoCollectionViewController.swift
//  VideoPlayerProject
//  This class is responsible for displaying videos in list and grid mod.
//  Created by Akmuhammet Ashyralyyev on 2021-06-07.
//

import UIKit

class VideoCollectionViewController: UIViewController {
    
    /// Outlets
    @IBOutlet var collection: UICollectionView!
    @IBOutlet weak var gridANDlistBtn: UIBarButtonItem!
    
    /// Local Variables
    var isList: Bool = true
    var videos: [Video] = []
    var spaceBetweenColumns: CGFloat = 5
    var spaceBetweenRows: CGFloat = 5
    var numberOfItemsInRow: CGFloat = 2
    var insetForTop: CGFloat = 5
    var insetForBottom: CGFloat = 5
    var insetForLeft: CGFloat = 5
    var insetForRight: CGFloat = 5
    
    /// Delegate protocals
    var delegate: VideoDelegateProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        setup()
    }
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        self.tabBarController!.selectedIndex += 1
    }
    
    /// This method set up videos and deals with initialization of collectionView
    private func setup() {
        getVideos()
        self.collection.register(CustomVideoGridCell.self, forCellWithReuseIdentifier: "CustomVideoGridCell")
        self.collection.register(CustomVideoListCell.self, forCellWithReuseIdentifier: "CustomVideoListCell")
    
        self.collection.delegate = self
        self.collection.dataSource = self
        self.collection.reloadData()
        
        gridANDlistBtn.title = "Grid"
    }
    
    /// This method creates new videos and assignes it to the videos array, where collectioenView will be using the data
    func getVideos() {
        let video1 = Video("Baris", "mp4")
        let video2 = Video("Funny hair", "mp4")
        let video3 = Video("Queen", "mp4")
        let video4 = Video("Roportaj Adam", "mp4")
        let video5 = Video("Venom 2", "mp4")
        
        videos.append(video1)
        videos.append(video2)
        videos.append(video3)
        videos.append(video4)
        videos.append(video5)
        
    }
    
    /// This method deals with the change on collectionview.
    /// It Transforms the view to grid from list or reverse if button is pressed
    /// - Parameter sender:
    @IBAction func changeView(_ sender: Any) {
        if isList {
            // Change title of UIBarButtonItem
            gridANDlistBtn.title = "list"
            
            isList = false
            self.collection.reloadData()
            print("Collection view is turned from list to grid.")
        } else {
            // Change title of UIBarButtonItem
            gridANDlistBtn.title = "grid"
            
            isList = true
            self.collection.reloadData()
            print("Collection view is truned from grid to list.")
        }
    }
    
    /// This method deals with all operations that will executed when there will be
    /// navigation to another view.
    /// - Parameter animated: animated description that is responsible for animating or not while navigating to another view
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.main.async {
            NotificationCenter.default.removeObserver(self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension VideoCollectionViewController: UICollectionViewDelegate {
    
    /// This method assignes video to the VideoPlayerViewController so it will be able to run the video when
    /// the view will be loaded. Also, navigation to that view is done from here.
    /// - Parameters:
    ///   - collectionView: collection view on the controller that is being selected of its cell
    ///   - indexPath: the path to the cell in the collectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "VideoPlayerViewController") as! VideoPlayerViewController
        self.delegate = controller
        self.delegate?.setVideo(videos[indexPath.row])
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}

extension VideoCollectionViewController: UICollectionViewDataSource {
    
    /// This method returns the total umber of items in collectionView
    /// - Parameters:
    ///   - collectionView: collectionView that item count will be retrieved
    ///   - section: the section that will hold cells
    /// - Returns: the total number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    /// This method generates the cell of the collectionView
    /// - Parameters:
    ///   - collectionView: collectionView that is asked
    ///   - indexPath: indexPath of the cell
    /// - Returns: cell of the collection view. It is either grid cell or list cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isList {
            // Modifications for List Cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomVideoListCell", for: indexPath) as! CustomVideoListCell
            cell.setVideo(video: videos[indexPath.row])
            return cell
        } else {
            // Modifications for Grid Cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomVideoGridCell", for: indexPath) as! CustomVideoGridCell
            cell.setVideo(video: videos[indexPath.row])
            return cell
        }
    }
}

extension VideoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    /// This method is responsible for dealing with spacing between rows in collectionview
    /// - Parameters:
    ///   - collectionView: <#collectionView description#>
    ///   - collectionViewLayout: <#collectionViewLayout description#>
    ///   - section: <#section description#>
    /// - Returns: <#description#>
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(spaceBetweenRows)
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - collectionViewLayout: collectionview's layour
    ///   - section: section of collectionview
    /// - Returns: spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(spaceBetweenColumns)
    }
    
    /// Description
    /// - Parameters:
    ///   - collectionView: collectionview
    ///   - collectionViewLayout: collectionveiw's layout
    ///   - indexPath: indexPath of the cell
    /// - Returns: size of the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let totalInset = insetForLeft+insetForRight
        if isList {
            return CGSize(width: width-totalInset, height: 120)
        } else {
            let totalSpace = totalInset + (numberOfItemsInRow-1) * spaceBetweenColumns
            return CGSize(width: (width-totalSpace)/numberOfItemsInRow, height: width/numberOfItemsInRow)
        }
    }
    
    /// This method returns the spacigs between top, bottom, right and left of the collection view.
    /// - Parameters:
    ///   - collectionView: collcetionView
    ///   - collectionViewLayout: the layout of the collcetionView
    ///   - section: the section of the collcetionView
    /// - Returns: the edge insets of the collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: insetForTop, left: insetForLeft, bottom: insetForBottom, right: insetForRight)
    }
}
