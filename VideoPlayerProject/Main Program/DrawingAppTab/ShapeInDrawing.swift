//
//  ShapeInDrawing.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-18.
//

import Foundation
import UIKit

class ShapeInDrawing {
    var color: UIColor = .black // default color is black
    var width: CGFloat = 4.0    // default width of the line is 4
    var points: [CGPoint]       // all points in line that are connected consequently
     
    init(color: UIColor, points: [CGPoint]) {
        self.color = color
        self.points = points
    }
}

