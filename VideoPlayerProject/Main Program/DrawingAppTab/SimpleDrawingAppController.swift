//
//  SimpleDrawingAppController.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-18.
//

import Foundation
import SwiftUI

class SimpleDrawingAppController: UIViewController {
    
    @IBOutlet weak var shapeChangeSwitch: UISwitch!
    @IBOutlet weak var drawingView: DrawingView!
    @IBOutlet weak var clearBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeChangeSwitch.setOn(false, animated: true)
        clearBtn.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clearAllDrawing(_ sender: Any) {
        drawingView.clearAllDrawing()
    }
    
    @IBAction func changeShape(_ sender: Any) {
        if shapeChangeSwitch.isOn {
            drawingView.currentShape = .triangle
            shapeChangeSwitch.setOn(true, animated: true)
        } else {
            drawingView.currentShape = .scretching
            shapeChangeSwitch.setOn(false, animated: true)
        }
    }
}
