//
//  DrawingView.swift
//  VideoPlayerProject
//
//  Created by Akmuhammet Ashyralyyev on 2021-06-18.
//

import Foundation
import UIKit

class DrawingView: UIView {
    
    var shapes = [ShapeInDrawing]()         // all lines in drawing
    var strokeWidth: CGFloat = 5.0
    var strokeColor: UIColor = .black
    var startingPoint: CGPoint?
    var currentShape: shape = .scretching   // default is scretching
    
    override func draw(_ rect: CGRect) {    // this method will be called in each touch move
                                            // add draw new points
        super.draw(rect)

        let context = UIGraphicsGetCurrentContext()
        
        for shape in shapes {
            for (index, point) in (shape.points.enumerated()) {
                if index == 0 {
                    context!.move(to: point)
                } else {
                    context!.addLine(to: point)
                }
                context!.setStrokeColor(shape.color.cgColor)
                context!.setLineWidth(shape.width)
            }
            
            context!.setLineCap(.round)
            context!.strokePath()
        }
    }
     
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch currentShape {
            case .triangle:
                shapes.append(TriangleInDrawing(color: UIColor(), points: [CGPoint]()))
            case .scretching:
                shapes.append(ShapeInDrawing(color: UIColor(), points: [CGPoint]()))
        }
        
        startingPoint = touches.first?.location(in: self)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first?.location(in: self)
        
        switch currentShape {
            case .scretching:
                let lastShape = shapes.popLast()!
                lastShape.points.append(touch!)
                lastShape.color = strokeColor
                lastShape.width = strokeWidth
                shapes.append(lastShape)
            case .triangle:
                let lastShape = shapes.popLast() as! TriangleInDrawing
                lastShape.setPoints(startingPoint: self.startingPoint!, currentPoint: touch!, color: strokeColor, width: strokeWidth)
                lastShape.color = strokeColor
                lastShape.width = strokeWidth
                shapes.append(lastShape)
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches ended")
    }
    
    func clearAllDrawing() {
        for shape in shapes {
            shape.points.removeAll()
        }
        shapes.removeAll()
        print("count is " + shapes.count.description)
        setNeedsDisplay()
    }
 }
