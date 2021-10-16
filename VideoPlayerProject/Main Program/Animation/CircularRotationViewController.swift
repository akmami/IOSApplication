//
//  CircularRotationViewController.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-29.
//

import UIKit

class CircularRotationViewController: UIViewController {
    
    @IBOutlet weak var rotateBtn: UIButton!
    @IBOutlet weak var smallSquare1: UIView!
    @IBOutlet weak var smallSquare2: UIView!
    @IBOutlet weak var smallSquare3: UIView!
    @IBOutlet weak var smallSquare4: UIView!
    lazy var allViews = [smallSquare1, smallSquare2, smallSquare3, smallSquare4]
    
    var rotationStatus: RotationStatus = .notRotating
    let circularRadious: CGFloat = 50
    var numberOfCompletedRotations = 0 {
        didSet {
            if numberOfCompletedRotations == 4 {
                numberOfCompletedRotations = 0
                rotationStatus = .notRotating
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
        
        smallSquare1.layer.cornerRadius = 4
        smallSquare2.layer.cornerRadius = 4
        smallSquare3.layer.cornerRadius = 4
        smallSquare4.layer.cornerRadius = 4
        
        rotateBtn.layer.cornerRadius = 10
        
        smallSquare1.translatesAutoresizingMaskIntoConstraints = false
        smallSquare1.layer.contents = UIImage(named: "ball.png")?.cgImage
        smallSquare1.backgroundColor = .none
        smallSquare1.isOpaque = false
        smallSquare1.contentMode = .scaleAspectFit
        
        smallSquare2.translatesAutoresizingMaskIntoConstraints = false
        smallSquare2.layer.contents = UIImage(named: "ball.png")?.cgImage
        smallSquare2.backgroundColor = .none
        smallSquare2.isOpaque = false
        smallSquare2.contentMode = .scaleAspectFit
        
        smallSquare3.translatesAutoresizingMaskIntoConstraints = false
        smallSquare3.layer.contents = UIImage(named: "ball.png")?.cgImage
        smallSquare3.backgroundColor = .none
        smallSquare3.isOpaque = false
        smallSquare3.contentMode = .scaleAspectFit
        
        smallSquare4.translatesAutoresizingMaskIntoConstraints = false
        smallSquare4.layer.contents = UIImage(named: "ball.png")?.cgImage
        smallSquare4.backgroundColor = .none
        smallSquare4.isOpaque = false
        smallSquare4.contentMode = .scaleAspectFit
        
        view.layer.contents = UIImage(named: "grass.jpg")?.cgImage
        view.contentMode = .scaleAspectFill
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if sender.direction == .left {
            self.tabBarController!.selectedIndex += 1
        }
        if sender.direction == .right {
            self.tabBarController!.selectedIndex -= 1
        }
    }
    
    @IBAction func startRotation(_ sender: Any) {
        if rotationStatus == .isRotating {
            print("it is already rotating")
            return
        }
        rotationStatus = .isRotating
        self.rotateView(duration: 3, delay: 3)
    }
    
    func rotateView(duration withDuration: Double, delay: Double) {
        
        for (index, view) in allViews.enumerated() {
            UIView.animateKeyframes(withDuration: Double(withDuration), delay: TimeInterval(Double(index) / withDuration + delay), options: .calculationModeLinear, animations: {
                
                var newX: CGFloat = 0
                var newY: CGFloat = 0
                var currentStartTime: Double = 0
                let timeIntervalBetweenAnimations: Double = 1.0 / (4 * Double(self.circularRadious) )
                while(newX < self.circularRadious) {
                    UIView.addKeyframe(withRelativeStartTime: currentStartTime, relativeDuration: 0.25) {
                        currentStartTime = currentStartTime + timeIntervalBetweenAnimations
                        newX = newX + 1
                        newY = self.circularRadious - sqrt(pow(self.circularRadious, 2) - pow(newX, 2))
                        view!.transform = CGAffineTransform(translationX: newX, y: newY)
                    }
                }
                while(newX > 0) {
                    UIView.addKeyframe(withRelativeStartTime: currentStartTime, relativeDuration: 0.25) {
                        currentStartTime = currentStartTime + timeIntervalBetweenAnimations
                        newX = newX - 1
                        newY = self.circularRadious + sqrt(pow(self.circularRadious, 2) - pow(newX, 2))
                        view!.transform = CGAffineTransform(translationX: newX, y: newY)
                    }
                }
                while(newX > -self.circularRadious) {
                    UIView.addKeyframe(withRelativeStartTime: currentStartTime, relativeDuration: 0.25) {
                        currentStartTime = currentStartTime + timeIntervalBetweenAnimations
                        newX = newX - 1
                        newY = self.circularRadious + sqrt(pow(self.circularRadious, 2) - pow(newX, 2))
                        view!.transform = CGAffineTransform(translationX: newX, y: newY)
                    }
                }
                while(newX < 0) {
                    UIView.addKeyframe(withRelativeStartTime: currentStartTime, relativeDuration: 0.25) {
                        currentStartTime = currentStartTime + timeIntervalBetweenAnimations
                        newX = newX + 1
                        newY = self.circularRadious - sqrt(pow(self.circularRadious, 2) - pow(newX, 2))
                        view!.transform = CGAffineTransform(translationX: newX, y: newY)
                    }
                }
            }, completion: {_ in
                self.numberOfCompletedRotations += 1
            })
        }
    }
}
