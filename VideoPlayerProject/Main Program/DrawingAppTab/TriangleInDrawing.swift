//
//  TriangleInDrawing.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-20.
//

import Foundation
import UIKit

class TriangleInDrawing: ShapeInDrawing {
     
    override init(color: UIColor, points: [CGPoint]) {
        super.init(color: color, points: points)
    }
    
    func setPoints(startingPoint from: CGPoint, currentPoint to: CGPoint, color: UIColor, width: CGFloat) {
        let topPointY = min(from.y, to.y)
        let topPointX = (from.x + to.x) / 2
        
        let leftCornerX = min(from.x, to.x)
        let leftCornerY = max(from.y, to.y)
        
        let rightCornerX = max(from.x, to.x)
        let rightCornerY = max(from.y, to.y)
        
        if points.count > 0 {
            points.removeAll()
        }

        points.append(CGPoint(x: topPointX, y: topPointY))
        points.append(CGPoint(x: leftCornerX, y: leftCornerY))
        points.append(CGPoint(x: rightCornerX, y: rightCornerY))
        points.append(CGPoint(x: topPointX, y: topPointY))          // Since from there is also needed to be drawn line
                                                                    // from last point to the first point in draw() function
                                                                    // extra top point is added here so the line will be drawn not to the first one
                                                                    // but to the exactly same point in coordinates with first one that.
     }
}
